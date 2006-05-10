Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964904AbWEJKch@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964904AbWEJKch (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 06:32:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964909AbWEJKch
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 06:32:37 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:17092 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964904AbWEJKcg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 06:32:36 -0400
Subject: Re: [PATCH -mm] BusLogic gcc 4.1 warning fixes
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Daniel Walker <dwalker@mvista.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <200605100255.k4A2tuuf031655@dwalker1.mvista.com>
References: <200605100255.k4A2tuuf031655@dwalker1.mvista.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 10 May 2006 11:44:35 +0100
Message-Id: <1147257875.17886.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2006-05-09 at 19:55 -0700, Daniel Walker wrote:
> I just commented out BusLogic_AbortCommand because the code that uses it is 
> commented out the same way .. It could just be removed .

Adds another leak in the failure case.
Agree about the AbortCommand function.

