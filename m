Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262267AbUKDPif@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262267AbUKDPif (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 10:38:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262268AbUKDPif
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 10:38:35 -0500
Received: from out011pub.verizon.net ([206.46.170.135]:16818 "EHLO
	out011.verizon.net") by vger.kernel.org with ESMTP id S262274AbUKDPhk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 10:37:40 -0500
Message-ID: <418A4CC0.3000206@verizon.net>
Date: Thu, 04 Nov 2004 10:37:36 -0500
From: Jim Nelson <james4765@verizon.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH 5/5] documentation: Remove drivers/char/README.cycladesZ
References: <20041103152246.24869.2759.68945@localhost.localdomain> <20041103152314.24869.56459.88722@localhost.localdomain> <20041103133103.GB4109@logos.cnet> <41891AF3.9050800@verizon.net> <20041103150947.GA4695@logos.cnet> <418955D2.7000700@verizon.net> <20041103214530.GD4716@logos.cnet>
In-Reply-To: <20041103214530.GD4716@logos.cnet>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH at out011.verizon.net from [68.238.31.6] at Thu, 4 Nov 2004 09:37:37 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:
>
>>My unofficial "guidelines" for what needs to be looked at more closely 
>>include: references to 2.0, 2.1, 2.2, 2.3, or 2.5 kernels, references to 
>>external modules, dates of 2002 or earlier, or just a "wait a minute, I 
>>don't think that's right". Not the prettiest technique, I know.
> 
> 
> I think what your intention is good, we dont want obsolete files
> which are not pertinent to v2.6 around - but you need to be careful. 
> 
> Old documents are not necessarily obsolete.
> 
> I would suggest sending all the patches to the respective maintainers,
> removing only the ones which are _obviously_ obsolete (like the CyclomY 
> which talks about upgrading from 2.0 to 2.2).
> 
> README.ecpa and README.scc, which you remove on your patches,
> look valid and useful documentation to me. 
> 

README.ecpa has been unchanged since at least 2.4.18, and the maintainer is no 
longer maintaining it in-kernel for 2.6.  Digi has a maintained version on their 
website.  The document details the user-space programs needed for firmware 
loading, and the version at Digi's website is maintained.

README.scc is fundamentally unchanged since at least 2.2.20.  That's my reason for 
removing it.  The file it points to was also last updated in the 2.2 kernel series 
- I need to get a more complete LXR setup here at home to pin it down more 
accurately.  It's for an AX.25 network adapter, and has no need to be in drivers/char.

> 
>>>Move the rest to Documentation/serial, fine.
> 
> 

