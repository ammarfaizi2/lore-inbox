Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273720AbRIQW2D>; Mon, 17 Sep 2001 18:28:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273723AbRIQW1x>; Mon, 17 Sep 2001 18:27:53 -0400
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:59142 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S273720AbRIQW1l>; Mon, 17 Sep 2001 18:27:41 -0400
Date: Tue, 18 Sep 2001 00:27:47 +0200
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: chris@boojiboy.eorbit.net
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: 2.4.9-ac9 APM w/Compaq 16xx laptop...
Message-ID: <20010918002747.G7988@arthur.ubicom.tudelft.nl>
In-Reply-To: <200109172004.NAA14399@boojiboy.eorbit.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200109172004.NAA14399@boojiboy.eorbit.net>; from chris@boojiboy.eorbit.net on Mon, Sep 17, 2001 at 01:04:14PM -0700
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2001 at 01:04:14PM -0700, chris@boojiboy.eorbit.net wrote:
> The Linux Kernel mailing list does not seem to be
> bearing any fruit with this APM/ACPI issue regarding
> clean power-off/reboot.  Are there any other groups
> that you are aware of that might have interest in
> investigating this bug?

Well, you might try ACPI and ask questions about that on the APCI
mailing list (see https://phobos.fs.tum.de/mailman/listinfo/acpi ),
maybe they know about a ACPI workaround (warning: ACPI is hairy).

> I still have linux-2.4.9-ac9, with the dmi_scan.c patch,
> and the APM configured as you suggested.  My computer
> bios is set to ACPI=off (even with this 'on' the behavior
> is the same).
> 
> shutdown -h    works correctly
> shutdown -r    hangs at "Restarting System".

I hoped that the dmi_scan.c patch would make the shutdown work so we
could differentiate between your laptop and that other Compaq laptop,
but unfortunately it doesn't. I currently don't know of a way to fix
your problem.

As a sidenote: Alan, would it be a good idea to have the DMI data
available in an easy way without having to ask people to edit
dmi_scan.c? Simple proc interface, or a kernel command line option, for
example.


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
