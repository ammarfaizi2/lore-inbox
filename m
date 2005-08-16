Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030211AbVHPQJ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030211AbVHPQJ0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 12:09:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030212AbVHPQJ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 12:09:26 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:19904 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S1030211AbVHPQJZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 12:09:25 -0400
Date: Tue, 16 Aug 2005 12:09:25 -0400
To: "Mukund JB." <mukundjb@esntechnologies.co.in>
Cc: hirofumi@mail.parknet.co.jp,
       linux-kernel-Mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: The Linux FAT issue on SD Cards.. maintainer support please
Message-ID: <20050816160925.GZ6714@csclub.uwaterloo.ca>
References: <43E52E630789A34CBC7422287BFB99AC01F12D@mail.esn.co.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43E52E630789A34CBC7422287BFB99AC01F12D@mail.esn.co.in>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2005 at 07:04:34PM +0530, Mukund JB. wrote:
> I have bought a "entermultimedia" USB 2.0 21-in-1 card.
> There are no Linux driver support in the CD  provided.
> Can u suggest me what is best bug (USB card reader) with Linux driver
> support in the Market.

Load usb drivers and usb-storage driver and scsi disk module (sd_mod).
Then it should show up as a scsi disk.  No modern OS requires drivers
added for usb drives.  They are just included.

Len Sorensen
