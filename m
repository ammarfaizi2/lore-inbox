Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932201AbWCBDbp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932201AbWCBDbp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 22:31:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932190AbWCBDbo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 22:31:44 -0500
Received: from mail.dvmed.net ([216.237.124.58]:64151 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932201AbWCBDbn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 22:31:43 -0500
Message-ID: <4406671C.2060209@pobox.com>
Date: Wed, 01 Mar 2006 22:31:40 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rdunlap@xenotime.net>
CC: Mark Lord <liml@rtr.ca>, jeff@garzik.org, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: libata queue contents
References: <20060301203901.GA6915@havoc.gtf.org>	<44063E09.1060303@rtr.ca> <20060301192740.1172e579.rdunlap@xenotime.net>
In-Reply-To: <20060301192740.1172e579.rdunlap@xenotime.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:
> On Wed, 01 Mar 2006 19:36:25 -0500 Mark Lord wrote:
> 
> 
>>Jeff Garzik wrote:
>>
>>>Here's the stuff that's pending for 2.6.17, in the
>>>libata-dev.git#upstream branch.  These changes are also auto-propagated
>>>to Andrew Morton's -mm via the #ALL meta-branch.
>>
>>Where are Randy's ACPI patches ?
> 
> 
> I haven't generated them against #upstream.  I'll try to do that
> in the next couple of days (assuming that I can git along with git).
> or can I use the git-rollup patch in -mm to diff against?

git-libata-all.patch in -mm is #upstream plus other stuff.  For the time 
being, for testing and current deployment, diffing against 
git-libata-all.patch, and sending the result to akpm, is probably the 
best route, and will get you quite close to #upstream.

	Jeff



