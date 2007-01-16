Return-Path: <linux-kernel-owner+w=401wt.eu-S1751195AbXAPOZz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751195AbXAPOZz (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 09:25:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751201AbXAPOZy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 09:25:54 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:44054 "EHLO
	pd5mo3so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751195AbXAPOZy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 09:25:54 -0500
Date: Tue, 16 Jan 2007 08:26:05 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: data corruption with nvidia chipsets and IDE/SATA drives // memory
 hole mapping related bug?!
In-reply-to: <45ACD918.2040204@scientia.net>
To: Christoph Anton Mitterer <calestyo@scientia.net>
Cc: linux-kernel@vger.kernel.org, cw@f00f.org, knweiss@gmx.de, ak@suse.de,
       andersen@codepoet.org, krader@us.ibm.com, lfriedman@nvidia.com,
       linux-nforce-bugs@nvidia.com
Message-id: <45ACE07D.3050207@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8; format=flowed
Content-transfer-encoding: 7bit
References: <fa.E9jVXDLMKzMZNCbslzUxjMhsInE@ifi.uio.no> <459C3F29.2@shaw.ca>
 <45AC06B2.3060806@scientia.net> <45AC08B9.5020007@scientia.net>
 <45AC1AEB.60805@shaw.ca> <45ACD918.2040204@scientia.net>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Anton Mitterer wrote:
> Ok,.. that sounds reasonable,.. so the whole thing might (!) actually be
> a hardware design error,... but we just don't use that hardware any
> longer when accessing devices via sata_nv.
> 
> So this doesn't solve our problem with PATA drives or other devices
> (although we had until now no reports of errors with other devices) and
> we have to stick with iommu=soft.
> 
> If one use iommu=soft the sata_nv will continue to use the new code for
> the ADMA, right?

Right, that shouldn't affect it.
