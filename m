Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266156AbTLIIwO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 03:52:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266157AbTLIIwO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 03:52:14 -0500
Received: from TYO202.gate.nec.co.jp ([210.143.35.52]:41924 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S266156AbTLIIwK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 03:52:10 -0500
To: Holger Schurig <h.schurig@mn-logistik.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: State of devfs in 2.6?
References: <200312081536.26022.andrew@walrond.org>
	<20031208154256.GV19856@holomorphy.com>
	<pan.2003.12.08.23.04.07.111640@dungeon.inka.de>
	<20031208233428.GA31370@kroah.com>
	<1070953338.7668.6.camel@simulacron>
	<20031209071303.GB24876@Master.launchmodem.com>
	<br41h9$mth$1@sea.gmane.org>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 09 Dec 2003 17:52:01 +0900
In-Reply-To: <br41h9$mth$1@sea.gmane.org>
Message-ID: <buooeuifk5q.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Holger Schurig <h.schurig@mn-logistik.de> writes:
> Devfs for embedded devices is just great.
> 
> * space. devfs doesn't eat space like the MAKEDEV approach.

Um, devfs does actually use a non-zero amount of code...

For a typical embedded device with about 5 entries in /dev I wouldn't
be surprised if devfs used a lot _more_ space...

-miles
-- 
`...the Soviet Union was sliding in to an economic collapse so comprehensive
 that in the end its factories produced not goods but bads: finished products
 less valuable than the raw materials they were made from.'  [The Economist]
