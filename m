Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262092AbVATWBo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262092AbVATWBo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 17:01:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262083AbVATWBn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 17:01:43 -0500
Received: from mail08.syd.optusnet.com.au ([211.29.132.189]:57262 "EHLO
	mail08.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262081AbVATWB2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 17:01:28 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16880.10712.159729.934973@wombat.chubb.wattle.id.au>
Date: Fri, 21 Jan 2005 08:59:52 +1100
From: Peter Chubb <peterc@gelato.unsw.edu.au>
To: "Jack O'Quin" <joq@io.com>
Cc: Paul Davis <paul@linuxaudiosystems.com>, Con Kolivas <kernel@kolivas.org>,
       linux <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       rlrevell@joe-job.com, CK Kernel <ck@vds.kolivas.org>,
       utz <utz@s2y4n2c.de>, Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [PATCH]sched: Isochronous class v2 for unprivileged soft rt scheduling
In-Reply-To: <87y8eo9hed.fsf@sulphur.joq.us>
References: <200501201542.j0KFgOwo019109@localhost.localdomain>
	<87y8eo9hed.fsf@sulphur.joq.us>
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Jack" == Jack O'Quin <joq@io.com> writes:


Jack> Looks like we need to do another study to determine which
Jack> filesystem works best for multi-track audio recording and
Jack> playback.  XFS looks promising, but only if they get the latency
Jack> right.  Any experience with that?  

The nice thing about audio/video and XFS is that if you know ahead of
time the max size of a file (and you usually do -- because you know
ahead of time how long a take is going to be) you can precreadte the
file as a contiguous chunk, then just fill it in, for minimum disc
latency.

--
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
The technical we do immediately,  the political takes *forever*
