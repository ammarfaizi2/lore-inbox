Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263599AbTCUMVh>; Fri, 21 Mar 2003 07:21:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263600AbTCUMVh>; Fri, 21 Mar 2003 07:21:37 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:59013 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S263599AbTCUMVg>; Fri, 21 Mar 2003 07:21:36 -0500
Date: Fri, 21 Mar 2003 12:32:14 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Daniel Pittman <daniel@rimspace.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux <-> Linux NFS issues.
Message-ID: <20030321123214.GB6664@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Daniel Pittman <daniel@rimspace.net>, linux-kernel@vger.kernel.org
References: <87isudm2ee.fsf@enki.rimspace.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87isudm2ee.fsf@enki.rimspace.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 21, 2003 at 09:37:13PM +1100, Daniel Pittman wrote:

 > The client machine reports, in dmesg:
 > NFS: server cheating in read reply: count 4096 > recvd 1000
 > The 'count' value is occasionally higher, but not often, and the 'recvd'
 > never seems to differ from 1000.

When I was last seeing this, there was also a lot of 'crap' packets
on the wire, with bogus header lengths etc (some of which were so
malformed they broke ethereal).

I've not retried any NFS tests since 2.5.60, sounds like the problem
is still there, so I'll do some more investigation soon.

		Dave

