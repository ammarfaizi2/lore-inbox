Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932220AbWBFQvN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932220AbWBFQvN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 11:51:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932219AbWBFQvN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 11:51:13 -0500
Received: from [202.131.75.34] ([202.131.75.34]:17367 "EHLO
	mail.shaolinmicro.com") by vger.kernel.org with ESMTP
	id S932212AbWBFQvL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 11:51:11 -0500
Message-ID: <43E77E69.8050702@shaolinmicro.com>
Date: Tue, 07 Feb 2006 00:50:49 +0800
From: David Chow <davidchow@shaolinmicro.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux drivers management
References: <43E71AD7.5070600@shaolinmicro.com> <43E71F75.7000605@stud.feec.vutbr.cz>
In-Reply-To: <43E71F75.7000605@stud.feec.vutbr.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Please read Documentation/stable_api_nonsense.txt in your copy of 
> Linux source.
I've read the document, I strongly disagree, because it is not relavant 
to my question or to my original purpose of this question.

Putting the driver source code in the kernel source tree has nothing to 
do with talking about a stable kernel API . Even you put the driver 
sources into the main kernel tree, it will still need a lot of work to 
port all drivers if the API changes. Driver sources can still host in a 
different project (e.g. projects in sf.net) and maintain open-source and 
om by the community, no difference than before

For different compile time options that affect data structures, this is 
well known a bad idea . These types of techniques no longer allowed in 
Java and other OO languages . Because I can simply say the code is not 
portable. If really need a recompile and optimize, the distro vendor 
should bare this, but according to the document, "As Linux supports a 
larger number of different devices "out of the box" than any other 
operating system" , do you think Linux should one day or some day grow 
to 1TB source tree to include all possible drivers for all hw come from 
the world? I don't see there is reason why a kernel or OS need to 
include all the drivers for all the hardware. I don't think there is any 
OS vendors on the market to capable to distribute all drivers integrity, 
then the choice is to make a disabled Linux OS because of an OSV who has 
only limited supporting resources to suppport and certify limited 
hardware devices.

Please see my other email responded to Jes about the learning curve and 
documentation issues of a Linux driver developer to pick up Linux skills.

regards,
David Chow
