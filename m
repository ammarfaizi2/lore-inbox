Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262570AbTJ3PP3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 10:15:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262574AbTJ3PP3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 10:15:29 -0500
Received: from main.gmane.org ([80.91.224.249]:25297 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262570AbTJ3PP2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 10:15:28 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Holger Schurig <h.schurig@mn-logistik.de>
Subject: Re: Post-halloween doc updates.
Date: Thu, 30 Oct 2003 16:15:25 +0100
Message-ID: <bnr9ud$rjq$2@sea.gmane.org>
References: <20031030141519.GA10700@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: KNode/0.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> - Blank screen after decompressing kernel?
>   Make sure your .config has
>    CONFIG_INPUT=y
>    CONFIG_VT=y
>    CONFIG_VGA_CONSOLE=y
>    CONFIG_VT_CONSOLE=y
>   A lot of people have discovered that taking their .config from 2.4 and
>   running make oldconfig to pick up new options leads to problems, notably
>   with CONFIG_VT not being set.

Would a couple of "default y" entries in Kconfig be a cure against this?


