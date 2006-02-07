Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932166AbWBGRf4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932166AbWBGRf4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 12:35:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932174AbWBGRfz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 12:35:55 -0500
Received: from animx.eu.org ([216.98.75.249]:33971 "EHLO animx.eu.org")
	by vger.kernel.org with ESMTP id S932166AbWBGRfz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 12:35:55 -0500
Date: Tue, 7 Feb 2006 12:39:27 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: Phillip Susi <psusi@cfl.rr.com>
Cc: Helge Hafting <helge.hafting@aitel.hist.no>,
       alex-lists-linux-kernel@yuriev.com, linux-kernel@vger.kernel.org
Subject: Re: non-fakeraid controllers
Message-ID: <20060207173927.GA16831@animx.eu.org>
Mail-Followup-To: Phillip Susi <psusi@cfl.rr.com>,
	Helge Hafting <helge.hafting@aitel.hist.no>,
	alex-lists-linux-kernel@yuriev.com, linux-kernel@vger.kernel.org
References: <20060207015126.GA12236@s2.yuriev.com> <43E85337.1090001@aitel.hist.no> <43E8C088.1040206@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43E8C088.1040206@cfl.rr.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phillip Susi wrote:
> Heinz wrote a utility called 'dmraid' which detects and activates 
> various hardware fakeraid volumes using the kernel device mapper.  I'm 
> using it at home to dual boot ubuntu and winxp ( just in case ) from a 
> stripe of two WD 10,000 rpm raptors and it works great.  I'm still 
> pushing to get it integrated into dapper.  At this time however, neither 
> my hardware, nor dmraid support raid-5.  Hopefully this will change in 
> the future. 

I've been wondering about dmraid.  I considered buying an adaptec sata raid
(hardware).  One of the drawbacks on hardware raid is the format isn't
compatible with any other card (or rather manufacturer).  So the question
is, has anyone written anything that can detect and activate disks from a
hardware raid controller when they are placed on a controller w/o any raid?

basically what I mean is, 3 disks, raid5 was in a system with hardware raid. 
the raid card blows up and cannot get another one so to get the data back,
place disks in another machine or on a standard controller and use software
raid or whatever to recover the data.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
 Got Gas???
