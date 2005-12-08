Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932693AbVLHWuv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932693AbVLHWuv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 17:50:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932694AbVLHWuu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 17:50:50 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:8391 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S932693AbVLHWuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 17:50:50 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC/RFT] suspend from userland
Date: Thu, 8 Dec 2005 23:52:07 +0100
User-Agent: KMail/1.9
Cc: kernel list <linux-kernel@vger.kernel.org>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>
References: <20051207011753.GA2526@elf.ucw.cz>
In-Reply-To: <20051207011753.GA2526@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512082352.07659.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wednesday, 7 December 2005 02:17, Pavel Machek wrote:
> I'd like to get some testing and comments on this. I know that
> userland part is messy and will not work on x86-64 etc, and I should
> obviously remove some extra printk's... but otherwise it should be okay.
> 
> Testing would be nice, too, but be a bit careful. It should not be
> more dangerous than /sys/power/resume, but... If you suspect something
> unusual, be sure to force fsck.

Could we please postpone it for some time?

First, the patch doesn't apply to the current -mm and the userland part is
incompatible with the code there to the extent of a serious breakage
(let alone the x86-64 issue).

Second, if I had some time to get my solution ready, we could compare the
alternatives instead of just discussing one of them.

Greetings,
Rafael


-- 
Beer is proof that God loves us and wants us to be happy - Benjamin Franklin
