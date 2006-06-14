Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751168AbWFNR40@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168AbWFNR40 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 13:56:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751194AbWFNR40
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 13:56:26 -0400
Received: from father.pmc-sierra.com ([216.241.224.13]:22666 "HELO
	father.pmc-sierra.bc.ca") by vger.kernel.org with SMTP
	id S1751168AbWFNR4Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 13:56:25 -0400
Message-ID: <478F19F21671F04298A2116393EEC3D531CF15@sjc1exm08.pmc_nt.nt.pmc-sierra.bc.ca>
From: Kallol Biswas <Kallol_Biswas@pmc-sierra.com>
To: Mike Galbraith <efault@gmx.de>
Cc: Stephen Hemminger <shemminger@osdl.org>, linux-kernel@vger.kernel.org,
       Radjendirane Codandaramane 
	<Radjendirane_Codandaramane@pmc-sierra.com>
Subject: RE: process starvation with 2.6 scheduler
Date: Wed, 14 Jun 2006 10:56:19 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, all 3 clients run on a Redhat 9 box.

-----Original Message-----
From: Mike Galbraith [mailto:efault@gmx.de] 
Sent: Tuesday, June 13, 2006 10:13 PM
To: Kallol Biswas
Cc: Stephen Hemminger; linux-kernel@vger.kernel.org; Radjendirane Codandaramane
Subject: RE: process starvation with 2.6 scheduler

On Tue, 2006-06-13 at 16:03 -0700, Kallol Biswas wrote:
> It seems that with the priority set to 19 the netserver processes do not starve but still we have unfair scheduling issue. The netperf clients do not timeout now but one of the servers runs much less than the other. It seems that thorough understanding of scheduling algorithm is essential at this point.

Are the clients all on one box?

	-Mike
