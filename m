Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284020AbRLWT1T>; Sun, 23 Dec 2001 14:27:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284073AbRLWT1K>; Sun, 23 Dec 2001 14:27:10 -0500
Received: from 12-224-36-149.client.attbi.com ([12.224.36.149]:60424 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S284020AbRLWT05>;
	Sun, 23 Dec 2001 14:26:57 -0500
Date: Sun, 23 Dec 2001 11:22:49 -0800
From: Greg KH <greg@kroah.com>
To: Peter Osterlund <petero2@telia.com>
Cc: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: "sr: unaligned transfer" in 2.5.2-pre1
Message-ID: <20011223112249.B4493@kroah.com>
In-Reply-To: <m2vgexzv90.fsf@ppro.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2vgexzv90.fsf@ppro.localdomain>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Sun, 25 Nov 2001 17:09:45 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 23, 2001 at 06:44:43PM +0100, Peter Osterlund wrote:
> 
> So, what changes are needed to make CD support work?

The usb-storage driver needs some changes to get it to work properly in
the 2.5.1 kernel due to the changes in the SCSI and bio layer.  I've
gotten a few other reports of problems, so you aren't alone :)

As for when the changes will be done, any volunteers?

thanks,

greg k-h
