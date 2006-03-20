Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964778AbWCTNYz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964778AbWCTNYz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 08:24:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964775AbWCTNYy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 08:24:54 -0500
Received: from rtr.ca ([64.26.128.89]:52865 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S964772AbWCTNYx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 08:24:53 -0500
Message-ID: <441EAD18.8070300@rtr.ca>
Date: Mon, 20 Mar 2006 08:24:40 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8) Gecko/20060305 SeaMonkey/1.1a
MIME-Version: 1.0
To: Stefan Seyfried <seife@suse.de>
Cc: Tom Marshall <tommy@home.tig-grr.com>, linux-kernel@vger.kernel.org,
       "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Suspend2-announce] Nigel's work and the future of Suspend2.
References: <200603071005.56453.nigel@suspend2.net> <20060308122500.GB3274@elf.ucw.cz> <1141839915.5382.49.camel@marvin.se.eecs.uni-kassel.de> <200603082139.06259.rjw@sisk.pl> <20060318060846.GA11546@home.tig-grr.com> <20060320081312.GA26527@suse.de>
In-Reply-To: <20060320081312.GA26527@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, Mar 17, 2006 at 10:08:46PM -0800, Tom Marshall wrote:
>  
>> I have the opposite problem, more or less (S3 not swsusp):
>>
>> I have two identical (except for different model drives) Thinkpad T42
>> laptops that exhibit the same behavior.  S3 mostly works but occasionally
>> fails to resume, for values of occasionally that vary between 1-2 successful
>> resumes before failure to several dozens.
>  
>> If anyone is willing to work with me on tracking down the issue in a vendor
>> kernel (Ubuntu Dapper), I would be more than happy to apply debug patches
>> and supply any debug info requested.

Try Randy Dunlop's libata-acpi patches -- they cured suspend/resume (RAM)
on my (Dell) notebook, which previously suffered like your Thinkpad.

-ml
