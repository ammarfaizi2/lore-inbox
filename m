Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263204AbUEWRfO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263204AbUEWRfO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 13:35:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263199AbUEWRfO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 13:35:14 -0400
Received: from gprs214-26.eurotel.cz ([160.218.214.26]:18304 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263205AbUEWRfG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 13:35:06 -0400
Date: Sun, 23 May 2004 19:34:57 +0200
From: Pavel Machek <pavel@ucw.cz>
To: samg <samg@seven4sky.com>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Smp swsusp testing wanted
Message-ID: <20040523173457.GB804@elf.ucw.cz>
References: <20040522143628.A6D3927327@smtp.etmail.cz> <40B0014B.1030002@seven4sky.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40B0014B.1030002@seven4sky.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >Hi! If you have smp machine where swsusp works with only one procesor and 
> >can test patches, please let me know. --p

> I have  (1) smp machine (dual proc), running 2.4.18/2.6.5/2.6.6,  If you 
> have a patch I can test it for you.

Please verify that swsusp works in "UP" mode, first. Then apply this
and go to "SMP" mode, and see if it still works.

I have SMP machine here but swsusp will not work there even in "UP"
mode; I'll need to debug it. 
								Pavel

-- 
934a471f20d6580d5aad759bf0d97ddc
