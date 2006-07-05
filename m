Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964846AbWGENWM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964846AbWGENWM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 09:22:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964849AbWGENWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 09:22:12 -0400
Received: from yzordderrex.netnoteinc.com ([212.17.35.167]:60122 "EHLO
	yzordderrex.lincor.com") by vger.kernel.org with ESMTP
	id S964846AbWGENWM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 09:22:12 -0400
Message-ID: <44ABBBF6.5070005@draigBrady.com>
Date: Wed, 05 Jul 2006 14:17:42 +0100
From: =?ISO-8859-1?Q?P=E1draig_Brady?= <P@draigBrady.com>
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "J. Bruce Fields" <bfields@fieldses.org>
CC: Bill Davidsen <davidsen@tmr.com>, Theodore Tso <tytso@mit.edu>,
       Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: ext4 features
References: <20060701163301.GB24570@cip.informatik.uni-erlangen.de> <20060704010240.GD6317@thunk.org> <44ABAF7D.8010200@tmr.com> <20060705125956.GA529@fieldses.org>
In-Reply-To: <20060705125956.GA529@fieldses.org>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J. Bruce Fields wrote:
> On Wed, Jul 05, 2006 at 08:24:29AM -0400, Bill Davidsen wrote:
> 
>>Theodore Tso wrote:
>>
>>>Some of the ideas which have been tossed about include:
>>>
>>>	* nanosecond timestamps, and support for time beyond the 2038
>>
>>The 2nd one is probably more urgent than the first. I can see a general 
>>benefit from timestamp in ms, beyond that seems to be a specialty 
>>requirement best provided at the application level rather than the bits 
>>of a trillion inodes which need no such thing.
> 
> 
> What's urgently needed for NFS (and I suspect for most other
> applications demanding higher timestamps) isn't really nanosecond
> precision so much as something that's guaranteed to increase whenever
> the file changes.

Yes please!
http://lkml.org/lkml/2001/10/8/18

Pádraig.
