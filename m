Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313070AbSGYMvX>; Thu, 25 Jul 2002 08:51:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313421AbSGYMvX>; Thu, 25 Jul 2002 08:51:23 -0400
Received: from mailhost.tue.nl ([131.155.2.5]:37425 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S313070AbSGYMvW>;
	Thu, 25 Jul 2002 08:51:22 -0400
Date: Thu, 25 Jul 2002 14:54:29 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Andrew Morton <akpm@zip.com.au>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [IDE bug] hdparm lockup
Message-ID: <20020725125429.GA13523@win.tue.nl>
References: <3D3F9012.B066A944@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D3F9012.B066A944@zip.com.au>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2002 at 10:43:46PM -0700, Andrew Morton wrote:

> quad:/home/akpm> 0 hdparm -i /dev/hdc 
> 
> /dev/hdc:
>  HDIO_GETGEO_BIG failed: Invalid argument
>  (what's this?)

Your hdparm uses an ioctl that doesnt exist (anymore).
Change to HDIO_GETGEO.

> The command
> 
> 	hdparm -d1 -A1 -m16 -u1 -a64 /dev/hdc
> 
> freezes the machine.

There I cannot help.
