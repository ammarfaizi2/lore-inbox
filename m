Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422735AbWBNTie@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422735AbWBNTie (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 14:38:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422740AbWBNTid
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 14:38:33 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:33763 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S1422735AbWBNTid (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 14:38:33 -0500
Message-ID: <43F2317B.4010203@cfl.rr.com>
Date: Tue, 14 Feb 2006 14:37:31 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Olivier Galibert <galibert@pobox.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Flames over -- Re: Which is simpler?
References: <Pine.LNX.4.44L0.0602131601220.4754-100000@iolanthe.rowland.org> <43F11A9D.5010301@cfl.rr.com> <BCC8C7FA-25A2-4460-A667-5AA88BF5BC6D@mac.com> <43F13BDF.3060208@cfl.rr.com> <DD0B9449-14AF-47D1-8372-DDC7E896DBC2@mac.com> <43F17850.8080600@cfl.rr.com> <F157 <20060214191402.GD51709@dspnet.fr.eu.org>
In-Reply-To: <20060214191402.GD51709@dspnet.fr.eu.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Feb 2006 19:39:46.0631 (UTC) FILETIME=[6934F570:01C6319E]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.52.1006-14267.000
X-TM-AS-Result: No--1.900000-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olivier Galibert wrote:
>
> I do expect to be able to move non-mounted disks around while
> suspended to disk, whatever their kind is (ide, sata, scsi, whatever).
> That's one of the main reasons you want a reliable suspend-to-disk on
> servers, another one being riding predicted powerloss (moving boxes
> around can be called a powerloss).

You also expect to have mounted disks survive the suspend.  Think about 
the root filesystem.  You can't unmount that and it would be really bad 
if that went offline ( kernel panic anyone? ) after a suspend.  And yes, 
the root fs can be on a USB drive. 


