Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263663AbUEXXPp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263663AbUEXXPp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 19:15:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263875AbUEXXPp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 19:15:45 -0400
Received: from stl-smtpout-01.boeing.com ([130.76.96.56]:55724 "EHLO
	stl-smtpout-01.boeing.com") by vger.kernel.org with ESMTP
	id S263663AbUEXXPn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 19:15:43 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6556.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: your mail
Date: Mon, 24 May 2004 16:15:26 -0700
Message-ID: <67B3A7DA6591BE439001F2736233351202B47E7E@xch-nw-28.nw.nos.boeing.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: your mail
Thread-Index: AcRB5LXaMmfCvJn3TiiL2CJ5/dNPnwAADGhg
From: "Laughlin, Joseph V" <Joseph.V.Laughlin@boeing.com>
To: "Bernd Petrovitsch" <bernd@firmix.at>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 24 May 2004 23:15:26.0318 (UTC) FILETIME=[FF3440E0:01C441E4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Bernd Petrovitsch [mailto:bernd@firmix.at] 
> Sent: Monday, May 24, 2004 4:13 PM
> To: Laughlin, Joseph V; linux-kernel@vger.kernel.org
> Subject: RE: your mail
> 
> 
> On Tue, 2004-05-25 at 01:04, Laughlin, Joseph V wrote:
> > > -----Original Message-----
> [...]
> > > On Mon, May 24, 2004 at 03:20:33PM -0700, Laughlin, 
> Joseph V wrote:
> > > > I've been tasked with modifying a 2.4 kernel so that a
> > > non-root user
> > > > can do the following:
> > > > 
> > > > Dynamically change the priorities of processes (up and 
> down) Lock
> > > > processes in memory Can change process cpu affinity
> [...]
> > Currently, we're using sched_setaffinity() to control it, which 
> > existed in our 2.4.19 kernel.  (but, you have to be root to use it, 
> > and we'd like non-root users to be able to change the affinity.)
> 
> And using sudo or setuid Binaries?
> 
> 	Bernd
> -- 

Not an option, unfortunately. 
