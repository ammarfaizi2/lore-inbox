Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267068AbTAZX5S>; Sun, 26 Jan 2003 18:57:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267079AbTAZX5S>; Sun, 26 Jan 2003 18:57:18 -0500
Received: from pat.uio.no ([129.240.130.16]:33170 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S267068AbTAZX5S>;
	Sun, 26 Jan 2003 18:57:18 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15924.30711.312462.624886@charged.uio.no>
Date: Mon, 27 Jan 2003 01:06:15 +0100
To: Christian Reis <kiko@async.com.br>
Cc: Neil Brown <neilb@cse.unsw.edu.au>, linux-kernel@vger.kernel.org,
       NFS@lists.sourceforge.net
Subject: Re: [NFS] Re: NFS client locking hangs for period
In-Reply-To: <20030126215650.A26147@blackjesus.async.com.br>
References: <20030124184951.A23608@blackjesus.async.com.br>
	<15922.2657.267195.355147@notabene.cse.unsw.edu.au>
	<20030126140200.A25438@blackjesus.async.com.br>
	<shs8yx7lgyt.fsf@charged.uio.no>
	<20030126204711.A25997@blackjesus.async.com.br>
	<15924.26856.298449.357899@charged.uio.no>
	<20030126215650.A26147@blackjesus.async.com.br>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Christian Reis <kiko@async.com.br> writes:

     > Is there a way of finding out exactly *which* files are being
     > locked at a certain time for a certain client?

Not really. 'cat /proc/locks' is about the closest you can get. That
will give you no NFS-specific information though.

Cheers,
  Trond
