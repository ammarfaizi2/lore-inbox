Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129324AbQK2Aai>; Tue, 28 Nov 2000 19:30:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129267AbQK2Aa2>; Tue, 28 Nov 2000 19:30:28 -0500
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:15365 "EHLO
        mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
        id <S129226AbQK2AaY>; Tue, 28 Nov 2000 19:30:24 -0500
Date: Wed, 29 Nov 2000 01:00:15 +0100
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: "Ian S. Nelson" <ian.nelson@echostar.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Loading initrd from flash
Message-ID: <20001129010015.E31304@arthur.ubicom.tudelft.nl>
In-Reply-To: <3A243CF7.C5CDF90F@echostar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A243CF7.C5CDF90F@echostar.com>; from ian.nelson@echostar.com on Tue, Nov 28, 2000 at 04:17:12PM -0700
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2000 at 04:17:12PM -0700, Ian S. Nelson wrote:
> Is there a standardized way of doing this yet?  I'm not using any MTD
> stuff, yet, and it doesn't look like something that the code currently
> does.

The standard way of doing it on ARM linux systems is that the boot
loader copies the contents of the (compressed) ramdisk from flash to a
place in ram where the kernel expects it to be. Another possibility is
to point the kernel to the flash memory and have it decompressed from
there.


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
