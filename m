Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262936AbVG3EVa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262936AbVG3EVa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 00:21:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262933AbVG3EVP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 00:21:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:13223 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262870AbVG3EUg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 00:20:36 -0400
Date: Fri, 29 Jul 2005 21:19:30 -0700
From: Andrew Morton <akpm@osdl.org>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: olh@suse.de, linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH 35/82] remove linux/version.h from
 drivers/scsi/cpqfcTSinit.c
Message-Id: <20050729211930.392209b0.akpm@osdl.org>
In-Reply-To: <1122691434.5108.30.camel@mulgrave>
References: <20050710193543.35.MfBvHx3206.2247.olh@nectarine.suse.de>
	<1122691434.5108.30.camel@mulgrave>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley <James.Bottomley@SteelEye.com> wrote:
>
> On Sun, 2005-07-10 at 19:35 +0000, Olaf Hering wrote:
> > changing CONFIG_LOCALVERSION rebuilds too much, for no appearent reason.
> > remove code for obsolete kernels
> 
> I can't seem to get any of these patches to apply:
> 
> Applying 'remove linux/version.h from drivers/scsi/cpqfcTSinit.c'
> 
> patching file drivers/scsi/cpqfcTSinit.c
> patch: **** malformed patch at line 4: #include <linux/config.h>
> 
> I've no idea what patch's problem is ... as far as I can tell there are
> no line breaks or illegal characters in the email.
> 

I suggest you not apply these patches - I have them all lined up and fixed
in -mm and we can do it in one hit post-2.6.13.
