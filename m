Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317422AbSHGN2k>; Wed, 7 Aug 2002 09:28:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317893AbSHGN2k>; Wed, 7 Aug 2002 09:28:40 -0400
Received: from mail.zmailer.org ([62.240.94.4]:15748 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id <S317422AbSHGN2j>;
	Wed, 7 Aug 2002 09:28:39 -0400
Date: Wed, 7 Aug 2002 16:32:17 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: davidsen@tmr.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Why 'mrproper'?
Message-ID: <20020807133217.GF32427@mea-ext.zmailer.org>
References: <Pine.LNX.4.33.0208070851230.2421-100000@iccarus.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0208070851230.2421-100000@iccarus.tmr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2002 at 08:55:25AM -0400, Bill Davidsen wrote:
> Having started out on the four floppy MCC "distribution" of Linux,
> building kernels clean with 'make distclean,' can someone provide a quick
> historical note as to what mrproper buys? A quick look at the tree after
> each didn't tell me much.

  Besides of the referral to domestic cleaning agent..
  The "mrproper" tag is being used all over the place
  to remove most of configuration and compilation related
  files.

  "distclean" calls at first "mrproper", and then does some
  additional cleanups, like various editor backup files.

  Thus "distclean" does more than "mrproper".

  Deeper understanding is available to those who read the top-level
  "Makefile" file.  ;-)   (Presuming they understand  makefile.)

/Matti Aarnio
