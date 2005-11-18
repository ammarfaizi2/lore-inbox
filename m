Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161073AbVKRMJ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161073AbVKRMJ3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 07:09:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161074AbVKRMJ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 07:09:29 -0500
Received: from main.gmane.org ([80.91.229.2]:19949 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1161073AbVKRMJ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 07:09:28 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Stefan Seyfried <seife@suse.de>
Subject: Re: [patch 1/1] cpufreq_conservative/ondemand: invert meaning of
 'ignore nice'
Date: Fri, 18 Nov 2005 13:07:01 +0100
Message-ID: <dlkg55$9tn$1@sea.gmane.org>
References: <20051110151111.GA16994@inskipp.digriz.org.uk> <200511110248.58751.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: charybdis-ext.suse.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050715 Thunderbird/1.0.6 Mnenhy/0.7.2.0
X-Accept-Language: en-us, en
In-Reply-To: <200511110248.58751.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> On Fri, 11 Nov 2005 02:11, Alexander Clouter wrote:
>> The use of the 'ignore_nice' sysfs file is confusing to anyone using it.
>> This removes the sysfs file 'ignore_nice' and in its place creates a
>> 'ignore_nice_load' entry which defaults to '1'; meaning nice'd processes
>> are not counted towards the 'business' caclulation.
> 
> And just for the last time I'll argue that the default should be 0. I have yet 
> to discuss this with any laptop user who thinks that 1 is the correct default 
> for ondemand.

i think that 1 is the correct default for ondemand.
And i know that discussion is fruitless - everybody has its own
preference, i prefer battery runtime before almost everything else :-)
-- 
Stefan Seyfried                  \ "I didn't want to write for pay. I
QA / R&D Team Mobile Devices      \ wanted to be paid for what I write."
SUSE LINUX Products GmbH, Nürnberg \                    -- Leonard Cohen

