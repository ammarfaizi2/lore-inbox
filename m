Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272681AbRILHoU>; Wed, 12 Sep 2001 03:44:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272682AbRILHoL>; Wed, 12 Sep 2001 03:44:11 -0400
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:18701 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S272681AbRILHn7>; Wed, 12 Sep 2001 03:43:59 -0400
Date: Wed, 12 Sep 2001 09:44:10 +0200
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: ajit k jena <ajit@indica.iitb.ac.in>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problems with Quantum DLT 4000 + HP C5173-4000
Message-ID: <20010912094406.A15765@arthur.ubicom.tudelft.nl>
In-Reply-To: <Pine.LNX.4.33.0109121004380.7146-100000@indica.iitb.ac.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0109121004380.7146-100000@indica.iitb.ac.in>; from ajit@indica.iitb.ac.in on Wed, Sep 12, 2001 at 10:05:17AM +0530
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2001 at 10:05:17AM +0530, ajit k jena wrote:
> We have a Quantum DLT 4000 SCSI-2 tape device connected to a
> RedHat Linux 7.1 box using BusLogic BT-950 card.

[...]

> When I try to do a tar onto the tape, I get the message:
> 
> 	Wrote only 0 of 10240 bytes
> 	Error is not recoverable: exiting now

Try to play with the "-b" option to get a correct blocking size. 10,
20, and 40 are useful numbers to try. It worked for me with a DLT 7000
tape drive connected to an SGI Origin200, though IRIX is not that
verbose in its error messages.

> The tape unit was attached to an HP9000 system before. The
> HP DLTtape IV cartridges are recommended for this drive.
> I thought there may something wrong with the particular
> cartridge and so I even tried brand new cartridges. The
> results are the same every time.

In my experience the brand of tapes doesn't matter. We use a mix of
Sony, Quantum, and Fuji tapes without any problem.


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
