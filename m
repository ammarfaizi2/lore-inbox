Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262531AbVG2Nlf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262531AbVG2Nlf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 09:41:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262571AbVG2Ni6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 09:38:58 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:39070 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S262604AbVG2Nhf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 09:37:35 -0400
Date: Fri, 29 Jul 2005 09:37:34 -0400
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: "Srinivas G." <srinivasg@esntechnologies.co.in>,
       linux-kernel-Mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: Unable to mount the SD card formatted using the DIGITAL CAMREA on Linux box
Message-ID: <20050729133733.GD31019@csclub.uwaterloo.ca>
References: <C349E772C72290419567CFD84C26E01704201D@mail.esn.co.in> <Pine.LNX.4.61.0507290757290.12897@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0507290757290.12897@chaos.analogic.com>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2005 at 08:02:14AM -0400, linux-os (Dick Johnson) wrote:
> Execute linux `fdisk` on the device. You may find that the
> ID byte is wrong.
> 
> Also, why do you need a special block device driver? The SanDisk
> and CompacFlash devices should look like IDE drives.

SD usually is secure digital (MMC compatible somewhat I believe).  It
does not provide IDE unlike CompactFlash.  SD uses a serial interface if
I remember correctly.

Len Sorensen
