Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271995AbRIMUSc>; Thu, 13 Sep 2001 16:18:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272020AbRIMUSW>; Thu, 13 Sep 2001 16:18:22 -0400
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:16907 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S271995AbRIMUSG>; Thu, 13 Sep 2001 16:18:06 -0400
Date: Thu, 13 Sep 2001 22:18:26 +0200
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: chris@boojiboy.eorbit.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.9-ac9 APM w/Compaq 16xx laptop...
Message-ID: <20010913221826.C742@arthur.ubicom.tudelft.nl>
In-Reply-To: <20010913091748.A21626@arthur.ubicom.tudelft.nl> <200109131955.MAA07591@boojiboy.eorbit.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200109131955.MAA07591@boojiboy.eorbit.net>; from chris@boojiboy.eorbit.net on Thu, Sep 13, 2001 at 12:55:56PM -0700
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2001 at 12:55:56PM -0700, chris@boojiboy.eorbit.net wrote:
> > Could you also tell what the kernel thinks about your laptop? It should
> > print things like "BIOS Vendor: Phoenix Technologies LTD".
> 
> Here is the newly patched dmesg output:
> 
> Linux version 2.4.9-ac9 (root@oso) (gcc version 2.95.3 20010315 (release)) #1 Thu Sep 13 10:51:23 PDT 2001
> ...
> Initializing RT netlink socket
> DMI 2.2 present.
> 11 structures occupying 403 bytes.
> DMI table at 0x000DC010.
> BIOS Vendor: Phoenix Technologies LTD
> BIOS Version: 4.06
> BIOS Release: 08/16/99
> System Vendor: Compaq.
> Product Name: Compaq PC.
> Version 0F0B.
> Serial Number 1V96CLS9D42J.
> Board Vendor: Compaq.
> Board Name: 0548h.
> Board Version: Rev.A.
> Asset Tag: No Asset Tag.
> apm: BIOS version 1.2 Flags 0x03 (Driver version 1.14)

Right, this might give some clues to diferentiate between board
revisions. Now we only need the output from a Compaq 12XL125 to see if
it differs.

But the most important question now is: does it work? Can you halt and
reboot your machine?


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
