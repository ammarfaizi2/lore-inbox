Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132527AbRDUUxA>; Sat, 21 Apr 2001 16:53:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132503AbRDUUwv>; Sat, 21 Apr 2001 16:52:51 -0400
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:9478 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S132514AbRDUUwQ>; Sat, 21 Apr 2001 16:52:16 -0400
Date: Sat, 21 Apr 2001 22:52:05 +0200
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Victor Julien <v.p.p.julien@let.rug.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.3+ sound distortion
Message-ID: <20010421225205.B2615@arthur.ubicom.tudelft.nl>
In-Reply-To: <Pine.LNX.4.05.10104211159030.5218-100000@cosmic.nrg.org> <01042121403000.00436@victor>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <01042121403000.00436@victor>; from v.p.p.julien@let.rug.nl on Sat, Apr 21, 2001 at 09:40:30PM +0200
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 21, 2001 at 09:40:30PM +0200, Victor Julien wrote:
> That did not help. The distortion is no stuttering, but noise in the music. 
> It's not specific to xmms, freeamp and xine also have the noise. The noise 
> reminds me of years ago when my father used a electric shaver witch gave 
> noise in the sound of my radio. Maybe that can give you an idea about the 
> sort of noise.
> 
> The changelog of 2.4.3 said that there were via-chipset-fixes undone, could 
> this be a problem of my chipset?

Possible. Another thing to check is if you started using an APM
monitoring program, like the GNOME battery_applet which reads /proc/apm
every couple of seconds. With every read of /proc/apm the APM driver
calls the APM BIOS, which on some systems runs quite long with
interrupts disabled. On my laptop this results in exactly the noise you
described.


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
