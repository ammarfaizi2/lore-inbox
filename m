Return-Path: <linux-kernel-owner+w=401wt.eu-S1758461AbWLIV4F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758461AbWLIV4F (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 16:56:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758492AbWLIV4F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 16:56:05 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:60521 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758461AbWLIV4C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 16:56:02 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <457B30EC.8020805@s5r6.in-berlin.de>
Date: Sat, 09 Dec 2006 22:55:56 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.8) Gecko/20061202 SeaMonkey/1.0.6
MIME-Version: 1.0
To: Pekka Enberg <penberg@cs.helsinki.fi>
CC: "Robert P. J. Day" <rpjday@mindspring.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kcalloc: Re-order the first two out-of-order args to
 kcalloc().
References: <Pine.LNX.4.64.0612081837020.6610@localhost.localdomain>	 <84144f020612090553n7fe309b7u54dd7f58424c4008@mail.gmail.com>	 <84144f020612090554o571f142bt7f59db2c0dfa782f@mail.gmail.com>	 <Pine.LNX.4.64.0612090901180.14206@localhost.localdomain> <84144f020612090618g27ac861ka4ad693a0dee1928@mail.gmail.com>
In-Reply-To: <84144f020612090618g27ac861ka4ad693a0dee1928@mail.gmail.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka Enberg wrote:
> On 12/9/06, Robert P. J. Day <rpjday@mindspring.com> wrote:
>> normally what i would do but, in the case of that patch, there are
>> five files affected, *all* of which are in totally different
>> subsystems (macintosh, net, scsi, usb, sunrpc).  are you suggesting
>> that up to 5 different people be CC'ed?
>>
>> and what about source-wide aesthetic changes that might touch dozens
>> or hundreds of files?
> 
> Well, it depends. There are no fixed rules in the art of patch
> feeding. FWIW, I probably would send this patch just to akpm too.

Yes, patches like this one are no big deal. But being involved in subsystem
maintenance, I find patches split up per subsystem much easier to handle.
Ccing the subsystem maintainers doen't make much sens if you don't split the
patch for them to integrate separately.
-- 
Stefan Richter
-=====-=-==- ==-- -=--=
http://arcgraph.de/sr/
