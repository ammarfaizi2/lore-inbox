Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270952AbTGPRIb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 13:08:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270961AbTGPRHe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 13:07:34 -0400
Received: from serenity.mcc.ac.uk ([130.88.200.93]:50189 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP id S270952AbTGPRFH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 13:05:07 -0400
Date: Wed, 16 Jul 2003 18:19:56 +0100
From: John Levon <levon@movementarian.org>
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       "Mallick, Asit K" <asit.k.mallick@intel.com>
Subject: Re: [PATCH] Use of Performance Monitoring Counters based on Model number
Message-ID: <20030716171956.GC19910@compsoc.man.ac.uk>
References: <C8C38546F90ABF408A5961FC01FDBF1902C7D0F9@fmsmsx405.fm.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C8C38546F90ABF408A5961FC01FDBF1902C7D0F9@fmsmsx405.fm.intel.com>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: King of Woolworths - L'Illustration Musicale
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19cpwa-0005zT-KW*Md2Y1s3tIlg*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 16, 2003 at 10:07:49AM -0700, Pallipadi, Venkatesh wrote:

> Attached is a small patch to make Linux kernel use of performance
> monitoring MSRs based on known processor models. Future processor
> implementation models may not support the same MSR layout.

If you're going to do this you should fix up arch/i386/oprofile/ to
error out similarly at least

regards
john
