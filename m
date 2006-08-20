Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751744AbWHTWkV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751744AbWHTWkV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 18:40:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751750AbWHTWkV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 18:40:21 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:53728 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751733AbWHTWkU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 18:40:20 -0400
Subject: Re: [PATCH] set*uid() must not fail-and-return on OOM/rlimits
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Solar Designer <solar@openwall.com>
Cc: Willy Tarreau <wtarreau@hera.kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <1156114275.4051.71.camel@localhost.localdomain>
References: <20060820003840.GA17249@openwall.com>
	 <1156097640.4051.24.camel@localhost.localdomain>
	 <20060820221208.GA21754@openwall.com>
	 <1156114275.4051.71.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 21 Aug 2006 00:00:28 +0100
Message-Id: <1156114828.4051.73.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sul, 2006-08-20 am 23:51 +0100, ysgrifennodd Alan Cox:
> being audited but I still think you are chasing the symptom, and its not

Umm s/not/a ...
> symptom of crap code, so you are not likely to "fix" security. A lot of
> BSD code for example doesn't check malloc returns but you don't want an
> auto-kill if mmap fails ?

