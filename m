Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272322AbRILXQL>; Wed, 12 Sep 2001 19:16:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272602AbRILXQC>; Wed, 12 Sep 2001 19:16:02 -0400
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:37649 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S272322AbRILXPs>; Wed, 12 Sep 2001 19:15:48 -0400
Date: Thu, 13 Sep 2001 01:16:06 +0200
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: chris@boojiboy.eorbit.net
Cc: bmacy@macykids.net, linux-kernel@vger.kernel.org
Subject: Re: 2.4.9-ac9 APM w/Compaq 16xx laptop...
Message-ID: <20010913011606.H20118@arthur.ubicom.tudelft.nl>
In-Reply-To: <200109122343.QAA20586@boojiboy.eorbit.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200109122343.QAA20586@boojiboy.eorbit.net>; from chris@boojiboy.eorbit.net on Wed, Sep 12, 2001 at 04:43:05PM -0700
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2001 at 04:43:05PM -0700, chris@boojiboy.eorbit.net wrote:
> This was discussed awhile back, maybe there are answer.  
> 
> Compaq Presario 1685.
> My bios supports ACPI
> 
> the roboot option  "shutdown -r" does
> not work with this laptop when I compile
> either APM or ACPI.  The behavior is a little
> different with each one.
> 
> When my bios is set ACPI=NO, and APM is compiled in:
> A 'shutdown -r' hangs after the "Restarting System" message.  
> Depressing the power switch cause a power off.

Try "Use real mode APM BIOS call to power off".

> When my bios is set ACPI=YES, and ACPI is compiled in:
> A 'shutdown -r' hangs after the "Restarting system" message.  
> Depressing the power switch causes a reboot.
> 
> I have a feeling this is ReiserFS related. 

I don't. Why would a filesystem have anything to do with APM or ACPI?


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
