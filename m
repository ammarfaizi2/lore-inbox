Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262971AbUB0TCa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 14:02:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262934AbUB0S7s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 13:59:48 -0500
Received: from 198.216-123-194-0.interbaun.com ([216.123.194.198]:55204 "EHLO
	mail.harddata.com") by vger.kernel.org with ESMTP id S262920AbUB0S6S
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 13:58:18 -0500
From: Mark <mark@harddata.com>
Organization: Hard Data Ltd
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Serial ATA (SATA) status report
Date: Fri, 27 Feb 2004 11:56:08 -0700
User-Agent: KMail/1.6
References: <403D5B3D.6060804@pobox.com> <403DF26E.8020908@tomt.net> <200402261423.56448.m.watts@eris.qinetiq.com>
In-Reply-To: <200402261423.56448.m.watts@eris.qinetiq.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200402271156.08829.mark@harddata.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On February 26, 2004 07:23 am, Mark Watts wrote:
> > Mark Watts wrote:
> > > Which one of these chips are the 3Ware cards based on?
> >
> > None of them. 3ware has its own chip, supported by the 3w-xxxx driver in
> > mainline 2.4 and 2.6. It's basicly exports the logical arrays as SCSI
> > devices.
>
> Neat. Are there any known issues with these cards? (Do they work with
> AMD-64?)

We have build Raid boxes with 3ware on x86_64. We have not had to run a 32bit 
OS to get it working and it works fine. There were some issues with more than 
4GB of memory but I believe 3ware has resolved them now.

-- 
Mark Lane, CET mailto:mark@harddata.com 
Hard Data Ltd. http://www.harddata.com 
T: 01-780-456-9771   F: 01-780-456-9772
11060 - 166 Avenue Edmonton, AB, Canada, T5X 1Y3
--> Ask me about our Excellent 1U Systems! <--
