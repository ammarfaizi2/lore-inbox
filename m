Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290809AbSBSJFP>; Tue, 19 Feb 2002 04:05:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290807AbSBSJDf>; Tue, 19 Feb 2002 04:03:35 -0500
Received: from finch-post-12.mail.demon.net ([194.217.242.41]:52241 "EHLO
	finch-post-12.mail.demon.net") by vger.kernel.org with ESMTP
	id <S290794AbSBSJD0>; Tue, 19 Feb 2002 04:03:26 -0500
Date: Tue, 19 Feb 2002 09:03:21 +0000
From: Nick Craig-Wood <ncw@axis.demon.co.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Dan Kegel <dank@kegel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: time goes backwards periodically on laptop if booted in low-power mode
Message-ID: <20020219090321.B366@axis.demon.co.uk>
In-Reply-To: <20020218213049.A28604@axis.demon.co.uk> <E16cvgK-0006uq-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E16cvgK-0006uq-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, Feb 18, 2002 at 09:50:44PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2002 at 09:50:44PM +0000, Alan Cox wrote:
> > This isn't fixing the root cause of the problem which is interactions
> > between the BIOS power management and the kernel I believe, but it
> > does fix the problem and is really quite cheap so perhaps might be
> 
> do_gettimeofday is still going to give strange results - and consider
> the case where you boot slow and speed up...

This isn't a perfect fix certainly.  Stopping time going backwards
stops the major application breakage though.

> If you can give me the DMI strings for the affected boxes I can add
> them to the DMi tables (see ftp://ftp.linux.org.uk/pub/linux/alan/DMI*)

[sent via private email]

-- 
Nick Craig-Wood
ncw@axis.demon.co.uk
