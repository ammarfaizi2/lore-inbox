Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263275AbTKEX5t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 18:57:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263281AbTKEX5s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 18:57:48 -0500
Received: from mail008.syd.optusnet.com.au ([211.29.132.212]:53977 "EHLO
	mail008.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S263275AbTKEX5s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 18:57:48 -0500
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16297.36426.396431.533422@wombat.chubb.wattle.id.au>
Date: Thu, 6 Nov 2003 10:56:58 +1100
To: jbarnes@sgi.com (Jesse Barnes)
Cc: linux-kernel@vger.kernel.org
Subject: Re: [DMESG] cpumask_t in action
In-Reply-To: <20031105224936.GA24431@sgi.com>
References: <20031105222202.GA24119@sgi.com>
	<20031105224936.GA24431@sgi.com>
X-Mailer: VM 7.14 under 21.4 (patch 14) "Reasonable Discussion" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Jesse" == Jesse Barnes <jbarnes@sgi.com> writes:

Jesse> We also have a large number of per-cpu and per-node
Jesse> processes...

Do you find /proc a bottleneck with this number of processes?  It
would seem to me that scanning /proc and opening/reading/closing all those
/proc/pid/stat, /proc/pid/status and /proc/pid/cmdline files would
take a long time.  

--
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
The technical we do immediately,  the political takes *forever*
