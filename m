Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313898AbSEASqw>; Wed, 1 May 2002 14:46:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313902AbSEASqv>; Wed, 1 May 2002 14:46:51 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:59921 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S313898AbSEASqu>;
	Wed, 1 May 2002 14:46:50 -0400
Date: Wed, 1 May 2002 10:43:19 -0700
From: Greg KH <greg@kroah.com>
To: Andrew T Sydelko <sydelko@ecn.purdue.edu>
Cc: linux-kernel@vger.kernel.org, torvalds@penguin.transmeta.com
Subject: Re: 2.5.1[012] compile fix under drivers/usb/storage
Message-ID: <20020501174319.GF1734@kroah.com>
In-Reply-To: <200205011458.g41EwwD6027915@philmont.ecn.purdue.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Wed, 03 Apr 2002 15:09:40 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 01, 2002 at 09:58:57AM -0500, Andrew T Sydelko wrote:
> 
> The following patch fixes compilation problems due to structure changes.
> The patch applies against 2.5.1[012].
> 
> drivers/usb/storage/datafab.c
> drivers/usb/storage/jumpshot.c

I don't think this is the proper fix for this code (due to highmem
issues).  Could you please work with the usb-storage author and
maintainer to get this fixed.

thanks,

greg k-h
