Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136056AbRAHSIQ>; Mon, 8 Jan 2001 13:08:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136192AbRAHSIG>; Mon, 8 Jan 2001 13:08:06 -0500
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:1034 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S136056AbRAHSIA>; Mon, 8 Jan 2001 13:08:00 -0500
Date: Mon, 8 Jan 2001 19:07:18 +0100
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Tim Sailer <sailer@bnl.gov>
Cc: Andrew Morton <andrewm@uow.edu.au>, linux-kernel@vger.kernel.org,
        jfung@bnl.gov
Subject: Re: Network Performance?
Message-ID: <20010108190718.Q3472@arthur.ubicom.tudelft.nl>
In-Reply-To: <20010104013340.A20552@bnl.gov>, <20010104013340.A20552@bnl.gov>; <20010105140021.A2016@bnl.gov> <3A56FD6C.93D09ABB@uow.edu.au>, <3A56FD6C.93D09ABB@uow.edu.au>; <20010107235123.B6028@bnl.gov> <3A5995CF.7AEFFBBD@uow.edu.au> <20010108090644.A12440@bnl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010108090644.A12440@bnl.gov>; from sailer@bnl.gov on Mon, Jan 08, 2001 at 09:06:45AM -0500
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 08, 2001 at 09:06:45AM -0500, Tim Sailer wrote:
> On Mon, Jan 08, 2001 at 09:26:23PM +1100, Andrew Morton wrote:
> > You're sending and receiving FTP/TCP/IP4 to Solaris and AIX hosts
> 
> Yup
> 
> > You have a 1000kbyte window size
> 
> Yup
> 
> > You have an 80 megabit/sec pipe.
> 
> Actually, 100 to the router, and then the WAN connection to the remote
> system is OC-3
> 
> > You're getting 1.8 megabits/sec.
> 
> Yup
> 
> > What is the round-trip time on the WAN?
> > 
> > Packet loss?
> 
> 101 packets transmitted, 101 packets received, 0% packet loss
> round-trip min/avg/max = 109.6/110.3/112.2 ms

I had similar problems two weeks ago. Turned out the connection between
two switches: one of them was hard wired to 100Mbit/s full duplex, the
other one to 100Mbit/s half duplex. Just to rule out the obvious...


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
