Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310713AbSCMP4P>; Wed, 13 Mar 2002 10:56:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310699AbSCMP4F>; Wed, 13 Mar 2002 10:56:05 -0500
Received: from fc.capaccess.org ([151.200.199.53]:17426 "EHLO fc.Capaccess.org")
	by vger.kernel.org with ESMTP id <S310676AbSCMPz4>;
	Wed, 13 Mar 2002 10:55:56 -0500
Message-id: <fc.008584120034e424008584120034e424.34e44b@Capaccess.org>
Date: Wed, 13 Mar 2002 10:55:14 -0500
Subject: [PATCH] 2.5.6-pre2 IDE cleanup 16
To: linux-kernel@vger.kernel.org
From: "Rick A. Hohensee" <rickh@Capaccess.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the credit where due department...

New note in osimplay....

                              [ Wrote 5164 lines ]

:; cLIeNUX /dev/tty3  11:14:52   /Ha3sm/colorgOS/tool
:;. osimplay
x86
libo
:; cLIeNUX /dev/tty3  11:14:55   /Ha3sm/colorgOS/tool
:;clump h


 clump creates a set of related offset names.  This sort of thing is
popular for associating arbitrary data items into groups. The data
associations can themseves be useful information. Data items in a clump
are defined by thier spacing, and thus have implied sizes.

        clump clumptypename item0 <size> item1 <size> ...

will make $clumptypename_item0 $clumptypename_item1 and so on be the
appropriate offsets from $clumptypename in the assembler state.
$clumptypename itself has a value of zero. A clumptypename_size is also
created that records the overall size of this type of clump. Sizes are in
bytes. Those offset values can then be used during assembly to instantiate
and perhaps initialize clumps of that type, or as address offsets at
runtime, including offsets on the return stack. For fancy initializations,
keep in mind that in this implementation of osimplay you have the full
power of the shell available for extending osimplay, and that if you need
to you can rewind the osimplay assembly pointer, H.

Linus Torvalds said he'd love to have C structs that could initialize the
values of particular fields (I think that's what he meant :o). As is often
the case versus C, osimplay doesn't provide that, but as is always the
case, osimplay doesn't prevent it either.


:; cLIeNUX /dev/tty3  11:14:57   /Ha3sm/colorgOS/tool
:;


Rick Hohensee

