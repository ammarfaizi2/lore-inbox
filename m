Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135529AbRDWTrS>; Mon, 23 Apr 2001 15:47:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135528AbRDWTrI>; Mon, 23 Apr 2001 15:47:08 -0400
Received: from mailhost.tue.nl ([131.155.2.5]:42312 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S135529AbRDWTq7>;
	Mon, 23 Apr 2001 15:46:59 -0400
Message-ID: <20010423214701.A18855@win.tue.nl>
Date: Mon, 23 Apr 2001 21:47:01 +0200
From: Guest section DW <dwguest@win.tue.nl>
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>,
        linux-kernel@vger.kernel.org
Subject: Re: 3-Ware Raid driver fails to update GenDisk head
In-Reply-To: <20010423120852.A32097@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <20010423120852.A32097@vger.timpanogas.org>; from Jeff V. Merkey on Mon, Apr 23, 2001 at 12:08:52PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2001 at 12:08:52PM -0600, Jeff V. Merkey wrote:
> 
> I am still working on this, but would appreciate some help from
> whomever owns this driver proper.  I have discovered that the 
> 3Ware drivers are not updating the gendisk_head with devices
> reported and exposed to user space as /dev/sda, sdb, etc.

But that is the job of sd.c, not of a driver.
