Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132053AbRDDT4u>; Wed, 4 Apr 2001 15:56:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132072AbRDDT4b>; Wed, 4 Apr 2001 15:56:31 -0400
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:34314 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S132053AbRDDT42>; Wed, 4 Apr 2001 15:56:28 -0400
Date: Wed, 4 Apr 2001 21:54:21 +0200
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: John Kodis <kodis@mail630.gsfc.nasa.gov>, linux-kernel@vger.kernel.org
Subject: Re: IDE RAID Hardware Advice
Message-ID: <20010404215421.O18749@arthur.ubicom.tudelft.nl>
In-Reply-To: <20010404100359.A16092@tux.gsfc.nasa.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010404100359.A16092@tux.gsfc.nasa.gov>; from kodis@mail630.gsfc.nasa.gov on Wed, Apr 04, 2001 at 10:03:59AM -0400
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 04, 2001 at 10:03:59AM -0400, John Kodis wrote:
> I'll be assembling a terabyte of IDE RAID network attached storage,
> and was looking for some advice on:
> 
>   - best supported and most reliable multi-channel IDE controller;

See http://www.linux-ide.org/chipsets.html . (3Ware controllers are the
only supported IDE RAID controller)

>   - best supported and most reliable NFS implementation;
> 
>   - any other random advise about things to do or not do in setting up
>     this type of system.

Don't use an NFS exported reiserfs filesystem. (see this mailing list
archive).


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
