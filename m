Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262577AbUBZAr7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 19:47:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262581AbUBZAr7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 19:47:59 -0500
Received: from gizmo04bw.bigpond.com ([144.140.70.14]:58274 "HELO
	gizmo04bw.bigpond.com") by vger.kernel.org with SMTP
	id S262577AbUBZAr5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 19:47:57 -0500
From: Ross Dickson <ross@datscreative.com.au>
Reply-To: ross@datscreative.com.au
Organization: Dat's Creative Pty Ltd
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.3 Boot Failure on Nforce2 Board
Date: Thu, 26 Feb 2004 10:48:50 +1000
User-Agent: KMail/1.5.1
Cc: mdj00b@acu.edu
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402261048.50262.ross@datscreative.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On Wed, 2004-02-25 at 10:17, Jeff Garzik wrote: 
 > Michael Joy wrote: 
 > > Hello, 
 > > We're having an interesting problem with the latest kernel release. On 
 > > an Albatron KM18G, latest bios, 1024MB system with athlon xp proc, 2.6.3 
 > > refuses to boot. It hangs on initializing the ide devices. 
 > > 
 
I use same Albatron KM18G Pro boards in imaging systems.

Back in early December had same lockup problems.

I also thought it was in ide driver at first but found it to be
associated with the change from 100Hz to 1000Hz timer ticks.

My latest patches for it for 2.6.3 are here. 
http://linux.derkeiler.com/Mailing-Lists/Kernel/2004-02/6520.html

They are probably not so experimental any more as others have had
good success with them.

Many users involved to get it this far working OK.
Plenty of earlier postings on topic in December and January.

One day NVIDIA and AMD might divulge actual cause but I am still
waiting. 

At least AMD communicated with me. I have not even received
a comment from NVIDIA.

Regards
Ross.
