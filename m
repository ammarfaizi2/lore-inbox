Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276953AbRJCTNV>; Wed, 3 Oct 2001 15:13:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276954AbRJCTNM>; Wed, 3 Oct 2001 15:13:12 -0400
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:43525 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S276953AbRJCTM5>; Wed, 3 Oct 2001 15:12:57 -0400
Date: Wed, 3 Oct 2001 21:13:21 +0200
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Sujal Shah <sshah@progress.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [POT] Which journalised filesystem ?
Message-ID: <20011003211321.G3638@arthur.ubicom.tudelft.nl>
In-Reply-To: <Pine.LNX.4.33L.0110030938130.4835-100000@imladris.rielhome.conectiva> <Pine.LNX.4.30.0110031448460.16788-100000@Appserv.suse.de> <20011003190315.G21866@emma1.emma.line.org> <1002130861.8159.64.camel@pcsshah>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1002130861.8159.64.camel@pcsshah>; from sshah@progress.com on Wed, Oct 03, 2001 at 01:40:36PM -0400
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 03, 2001 at 01:40:36PM -0400, Sujal Shah wrote:
> On Wed, 2001-10-03 at 13:03, Matthias Andree wrote:
> > hdparm -W0 /dev/hda is your friend.
> 
> Dumb question: when would you want it to be -W1?
> 
> I mean, I can imagine maybe media recording or something where you might
> *really* want the performance increase...  but generally speaking, I
> want my data to be there in case things blow up.

I've used it in the past for an SGI Octane that was (and still is) used
to do real time TV studio quality (CCIR-601 YUV422 data, about 20MB/s)
record/playback to four striped SCSI disks.

> does anyone know what the performance increase is?

It made the difference between "doesn't cut it" and "enough headroom".
IIRC it was something like 18MB/s without and 30MB/s with write
caching, but don't quote me on the exact numbers.


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
