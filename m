Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280660AbRKTVMv>; Tue, 20 Nov 2001 16:12:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280824AbRKTVMm>; Tue, 20 Nov 2001 16:12:42 -0500
Received: from elin.scali.no ([62.70.89.10]:7686 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S280660AbRKTVMe>;
	Tue, 20 Nov 2001 16:12:34 -0500
Message-ID: <3BFAC5A1.81474E74@scali.no>
Date: Tue, 20 Nov 2001 22:05:37 +0100
From: Steffen Persvold <sp@scali.no>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-13win4lin i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Christopher Friesen <cfriesen@nortelnetworks.com>
CC: root@chaos.analogic.com, linux-kernel@vger.kernel.org
Subject: Re: Swap
In-Reply-To: <Pine.LNX.3.95.1011120111730.7650A-100000@chaos.analogic.com> <3BFA8F87.9FB4C13E@nortelnetworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christopher Friesen wrote:
> 
> "Richard B. Johnson" wrote:
> >
> > On Tue, 20 Nov 2001, Wolfgang Rohdewald wrote:
> >
> > > On Tuesday 20 November 2001 15:51, J.A. Magallon wrote:
> > > > When a page is deleted for one executable (because we can re-read it from
> > > > on-disk binary), it is discarded, not paged out.
> > >
> > > What happens if the on-disk binary has changed since loading the program?
> > > -
> >
> > It can't. That's the reason for `install` and other methods of changing
> > execututable files (mv exe-file exe-file.old ; cp newfile exe-file).
> > The currently open, and possibly mapped file can be re-named, but it
> > can't be overwritten.
> 
> Actually, with NFS (and probably others) it can.  Suppose I change the file on
> the server, and it's swapped out on a client that has it mounted.  When it swaps
> back in, it can get the new information.
> 

This sounds really dangerous... What about shared libraries ??

Regards,
-- 
  Steffen Persvold   | Scalable Linux Systems |   Try out the world's best   
 mailto:sp@scali.no  |  http://www.scali.com  | performing MPI implementation:
Tel: (+47) 2262 8950 |   Olaf Helsets vei 6   |      - ScaMPI 1.12.2 -         
Fax: (+47) 2262 8951 |   N0621 Oslo, NORWAY   | >300MBytes/s and <4uS latency
