Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129597AbQKTXXc>; Mon, 20 Nov 2000 18:23:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129625AbQKTXXW>; Mon, 20 Nov 2000 18:23:22 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:18439 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S129636AbQKTXXM> convert rfc822-to-8bit; Mon, 20 Nov 2000 18:23:12 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Oliver Poths <oliver.poths@linsoft.de>
Date: Tue, 21 Nov 2000 09:52:44 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-ID: <14873.43836.407559.976245@notabene.cse.unsw.edu.au>
Cc: Tigran Aivazian <tigran@veritas.com>, linux-kernel@vger.kernel.org
Subject: Re: kernel-2.4.0-test11 crashed again; this time i send you the
 Oops-message 
In-Reply-To: message from Oliver Poths on Monday November 20
In-Reply-To: <Pine.LNX.4.21.0011202121000.1664-100000@penguin.homenet>
	<20001120.22074300@rock>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday November 20, oliver.poths@linsoft.de wrote:
> Here´s the output of ksymoops:
> 
> 
> >>EIP; c01c8e66 <xor_block+46/90>   <=====

In drivers/md/Makefile, swap the order of "raid5.o xor.o" to be "xor.o
raid5.o", recompile, install, reboot.

NeilBrown
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
