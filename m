Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262306AbTJ3KPS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 05:15:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262315AbTJ3KPS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 05:15:18 -0500
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:38868 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id S262306AbTJ3KPI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 05:15:08 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Question on SIGFPE
Date: Thu, 30 Oct 2003 15:43:42 +0530
Message-ID: <94F20261551DC141B6B559DC491086727C8C63@blr-m3-msg.wipro.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Question on SIGFPE
Thread-Index: AcOezlLdBXzUFSEYRAmsichVrS3wTwAABHWA
From: "Sreeram Kumar Ravinoothala" <sreeram.ravinoothala@wipro.com>
To: "Magnus Naeslund(t)" <mag@fbab.net>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 30 Oct 2003 10:13:42.0796 (UTC) FILETIME=[7F0484C0:01C39ECE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	We get this problem when we run it on disk on chip where linux
2.4.5 is used.

Thanks and Regards
Sreeram

---Never doubt that a small group of thoughtful, committed people can
change the world. Indeed, it is the only thing that ever has. -- Copied
from a mail
 

-----Original Message-----
From: Magnus Naeslund(t) [mailto:mag@fbab.net] 
Sent: Thursday, October 30, 2003 3:44 PM
To: Sreeram Kumar Ravinoothala
Cc: linux-kernel@vger.kernel.org
Subject: Re: Question on SIGFPE


Sreeram Kumar Ravinoothala wrote:

> Hi,
> 	I am trying to run a multi threaded application on kernel 2.4.5.
The 
> application vanishes without leaving any trace (no core dump) when 
> there is a link up on the hardware I use. If I try to debug I see the 
> application being killed because of SIGFPE. Can anyone throw some 
> light on this please? Also please cc the answer to me as I am not a 
> member of the list.
 >

The most obvious thing is to check you code for a divide by zero error.

Magnus

