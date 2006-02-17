Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751323AbWBQCs0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751323AbWBQCs0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 21:48:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751329AbWBQCsZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 21:48:25 -0500
Received: from smtp.osdl.org ([65.172.181.4]:62375 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751323AbWBQCsZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 21:48:25 -0500
Date: Thu, 16 Feb 2006 18:50:29 -0800
From: Andrew Morton <akpm@osdl.org>
To: John M Flinchbaugh <john@hjsoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: can't loadkeys anymore? (was Re: Linux-2.6.15.4 login errors)
Message-Id: <20060216185029.00271d2b.akpm@osdl.org>
In-Reply-To: <20060216203007.GB17970@butterfly.hjsoft.com>
References: <Pine.LNX.4.61.0602160859380.4753@chaos.analogic.com>
	<20060216142824.GD13188@redhat.com>
	<20060216203007.GB17970@butterfly.hjsoft.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John M Flinchbaugh <john@hjsoft.com> wrote:
>
> This still leaves the question: Why is loadkeys no longer permitted to
> set the keymap for a tty the user currently owns?  What if the user
> really does want to run loadkeys without having to be root (ie. to load
> dvorak keymap)?

The problem is that you could possibly change keys to do evil things, then
log out, leaving a trap for the next user.

