Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317530AbSFECvX>; Tue, 4 Jun 2002 22:51:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317532AbSFECvW>; Tue, 4 Jun 2002 22:51:22 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:24079 "HELO
	vladimir.pegasys.ws") by vger.kernel.org with SMTP
	id <S317530AbSFECvV>; Tue, 4 Jun 2002 22:51:21 -0400
Date: Tue, 4 Jun 2002 19:51:13 -0700
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: RAID-6 support in kernel?
Message-ID: <20020604195113.G7742@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0206031020290.30424-100000@mail.pronto.tv> <Pine.GSO.4.21.0206030213510.23709-100000@gecko.roadtoad.net> <20020603113128.C13204@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2002 at 11:31:28AM +0200, Vojtech Pavlik wrote:
> On Mon, Jun 03, 2002 at 02:25:22AM -0700, Derek Vadala wrote:
> 
> He was thinking "mirror", not "stripe". Mirror of 2 RAID-5 arrays (would
> be probably called RAID-15 (when there is a RAID-10 for mirrored stripe
> arrays)), can withstand any two disks failing anytime. Even more for
> certain combinations. But it is terribly inefficient.

All the authoritative literature says that
RAID-10 is striped mirrors (survive ~1/n 2 disk failures.)
RAID-0+1 is mirrored stripes (survive ~1/2 2 disk failures.)

What he is describing would be RAID-5+1, mirrored RAID-5s.
RAID-15 would be a RAID-5 of mirrors.
Both of these could survive any 3 disk failures.

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
