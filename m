Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264155AbUEXXm2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264155AbUEXXm2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 19:42:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264272AbUEXXm2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 19:42:28 -0400
Received: from stl-smtpout-01.boeing.com ([130.76.96.56]:64184 "EHLO
	stl-smtpout-01.boeing.com") by vger.kernel.org with ESMTP
	id S264155AbUEXXmO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 19:42:14 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6556.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Modifying kernel so that non-root users have some root capabilities
Date: Mon, 24 May 2004 16:41:59 -0700
Message-ID: <67B3A7DA6591BE439001F2736233351202B47E87@xch-nw-28.nw.nos.boeing.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Modifying kernel so that non-root users have some root capabilities
Thread-Index: AcRB5w38Xc40pePISeOWIYYJXwoujwAANWkA
From: "Laughlin, Joseph V" <Joseph.V.Laughlin@boeing.com>
To: "Steve Youngs" <steve@youngs.au.com>,
       "Linux Kernel List" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 24 May 2004 23:42:00.0198 (UTC) FILETIME=[B53B0A60:01C441E8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> -----Original Message-----
> From: Steve Youngs [mailto:steve@youngs.au.com] 
> Sent: Monday, May 24, 2004 4:24 PM
> To: Linux Kernel List
> Cc: Laughlin, Joseph V
> Subject: Re: Modifying kernel so that non-root users have 
> some root capabilities
> 
> 
> * Joseph V Laughlin <Laughlin> writes:
> 
>   > I've been tasked with modifying a 2.4 kernel so that a 
> non-root user can
>   > do the following:
> 
>   > Dynamically change the priorities of processes (up and down)
>   > Lock processes in memory
>   > Can change process cpu affinity
> 
> I'm assuming that there are user-land tools to do these 
> things now for root, right?  So why not look into things like 
> sudo(8) or even setuid executables? 
> 

In short, it comes down to permissions problems with NFS mounted
directories, combined with Rational ClearCase issues, combined with
stringent security requirements.
