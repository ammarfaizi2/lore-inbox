Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131200AbRAPBFQ>; Mon, 15 Jan 2001 20:05:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131290AbRAPBFH>; Mon, 15 Jan 2001 20:05:07 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:57360 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S131200AbRAPBFA>; Mon, 15 Jan 2001 20:05:00 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Date: Tue, 16 Jan 2001 12:00:57 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14947.40265.723513.478711@notabene.cse.unsw.edu.au>
Cc: Neil Brown <neilb@cse.unsw.edu.au>, Jure Pecar <pegasus@telemach.net>,
        linux-kernel@vger.kernel.org
Subject: Re: FS corruption on 2.4.0-ac8
In-Reply-To: message from Marcelo Tosatti on Monday January 15
In-Reply-To: <3A637E15.DDC8C38@telemach.net>
	<Pine.LNX.4.21.0101151910130.834-100000@freak.distro.conectiva>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday January 15, marcelo@conectiva.com.br wrote:
> 
> 
> On Mon, 15 Jan 2001, Jure Pecar wrote:
> 
> > 
> > There is something not that usual about my setup: i run raid1 /boot and
> > raid5 root with one disk disconnected (its simply too loud...), so the
> > array is in degraded mode all the time. Other hardware is more or less
> > standard, p200 classic, 430vx board, adaptec2940u, 64mb ram.
> > 
> > Is this a known problem? If it's not, please advise me on how to provide
> > more usefull informations.
> 
> Neil, 
> 
> This is the second report of corruption with RAID5. 
> 
> Do you know if any of your recent changes can be the reason?
> 

Probably related.
There is growing evidence of problems when accessing a degraded array,
but I don't know if it is writing bad data, or reading incorrectly, or
just getting the parity calculation wrong...
I'll try to have a look, but with linux.conf.au coming up, it might
not be very soon.

NeilBrown
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
