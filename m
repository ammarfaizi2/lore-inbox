Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262279AbTEFCgq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 22:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262280AbTEFCgp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 22:36:45 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.202]:60923 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S262279AbTEFCgl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 22:36:41 -0400
To: Mark Grosberg <mark@nolab.conman.org>
Cc: "Richard B. Johnson" <root@chaos.analogic.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFD] Combined fork-exec syscall.
References: <Pine.BSO.4.44.0304281219420.22115-100000@kwalitee.nolab.conman.org>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 06 May 2003 11:48:57 +0900
In-Reply-To: <Pine.BSO.4.44.0304281219420.22115-100000@kwalitee.nolab.conman.org>
Message-ID: <buo3cjsu6w6.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Grosberg <mark@nolab.conman.org> writes:
> And maybe on your 797.90 BogoMips super fast machine the extra syscall
> doesn't matter. But on my current server hardware (16.59 BogoMIPS) it is a
> savings.

Are you sure it's really all that bad?

The machines I use are even slower (~6 bogomips), but system calls still
seem pretty fast; I've measured them as having about a total
65-instruction overhead on my arch -- which is a lot slower than a
function call to be sure, but presumably the actual work done by the
system call ends up being more.

-Miles
-- 
`The suburb is an obsolete and contradictory form of human settlement'
