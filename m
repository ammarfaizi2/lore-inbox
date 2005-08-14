Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932540AbVHNPBH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932540AbVHNPBH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Aug 2005 11:01:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932541AbVHNPBH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Aug 2005 11:01:07 -0400
Received: from nproxy.gmail.com ([64.233.182.192]:20678 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932540AbVHNPBG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Aug 2005 11:01:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fCsysKi6RfZ188CJqXBnNVcBNBcry1TmeMPRs4W3wlpyRpHrQ0+1N/DDe+pDDlQ9Ii5YEgQdVI37ffJhI1K/W01FDBUxpOTkMPcYK6dXSdkT1mHFGQUrK4X/DhYBGTB8mtJS6+aNvAgaRjktz9AgED040NYledkW/YxwvwitzsM=
Message-ID: <58cb370e050814080120291979@mail.gmail.com>
Date: Sun, 14 Aug 2005 17:01:04 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: IT8212/ITE RAID
Cc: Daniel Drake <dsd@gentoo.org>, CaT <cat@zip.com.au>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1124026385.14138.37.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050814053017.GA27824@zip.com.au> <42FF263A.8080009@gentoo.org>
	 <20050814114733.GB27824@zip.com.au> <42FF3CBA.1030900@gentoo.org>
	 <1124026385.14138.37.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/14/05, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Sul, 2005-08-14 at 13:44 +0100, Daniel Drake wrote:
> > > [227523.229557] hda: 390721968 sectors (200049 MB) w/8192KiB Cache, CHS=24321/255/63, BUG
> 
> Thats probably the fact other patches from -ac are missing in base. It
> should be harmless.

Therefore please submit them.

> > > [227523.229631] hda: cache flushes not supported
> > > [227523.229932]  hda:hda: recal_intr: status=0x51 { DriveReady SeekComplete Error }
> > > [227523.230905] hda: recal_intr: error=0x04 { DriveStatusError }
> > > [227523.230952] ide: failed opcode was: unknown
> 
> Yep - on my "wtf" list. In some cases we send a strange command to the
> IT8212 drive. I'm still trying to find the guilty command we send (none
> of my drives do this), so that I can fix the ident adjustment to stop
> it. The noise is just the command being rejected which is ok but messy
> and wants stomping.

small hint: WIN_RESTORE
