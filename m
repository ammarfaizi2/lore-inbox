Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261443AbUD1UxR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261443AbUD1UxR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 16:53:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261530AbUD1UCs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 16:02:48 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:54959 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261443AbUD1TRM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 15:17:12 -0400
Date: Tue, 27 Apr 2004 22:34:27 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Theodore Ts'o" <tytso@mit.edu>,
       Miquel van Smoorenburg <miquels@cistron.nl>,
       linux-kernel@vger.kernel.org
Subject: Re: File system compression, not at the block layer
Message-ID: <20040427203426.GB6116@openzaurus.ucw.cz>
References: <408951CE.3080908@techsource.com> <c6bjrd_pms_1@news.cistron.nl> <20040423174146.GB5977@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040423174146.GB5977@thunk.org>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > >Well, why not do the compression at the highest layer?
> > >[...] doing it transparently and for all files.
> > 
> > http://e2compr.sourceforge.net/
> 
> It's been done (see the above URL), but given how cheap disk space has
> gotten, and how the speed of CPU has gotten faster much more quickly
> than disk access has, many/most people have not be interested in
> trading off performance for space.  As a result, there are race

Is CPU_speed / disk_throughput increasing? If so, compression
might help once again. CPU_speed / net_throughput probably is
increasing, so compressedNFS would probably make sense.
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

