Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262962AbUCXArJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 19:47:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262960AbUCXArJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 19:47:09 -0500
Received: from mail014.syd.optusnet.com.au ([211.29.132.160]:62670 "EHLO
	mail014.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262962AbUCXArE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 19:47:04 -0500
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16480.55934.301442.401960@wombat.chubb.wattle.id.au>
Date: Wed, 24 Mar 2004 11:46:54 +1100
To: Christof <mail@pop2wap.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: synchronous serial port communication (16550A)
In-Reply-To: <703905114@toto.iv>
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Christof" == Christof  <mail@pop2wap.net> writes:

Christof> Miquel van Smoorenburg wrote:
>> Why don't you simply turn on hardware flow control (i.e. enable
>> CRTSCTS with tcsetattr() or even stty) ?
>> 
>> Mike.

Christof> RTS has a special meaning with this lcd-controller, so I
Christof> don't want that it is set without my implicit will.  - To

Then  wire it to something other than CTS at the host
end. 


--
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
The technical we do immediately,  the political takes *forever*

