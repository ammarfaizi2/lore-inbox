Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262933AbVAFR7Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262933AbVAFR7Y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 12:59:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262967AbVAFR6Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 12:58:25 -0500
Received: from boa.mtg-marinetechnik.de ([62.153.155.10]:37358 "EHLO
	cascabel.mtg-marinetechnik.de") by vger.kernel.org with ESMTP
	id S262933AbVAFRvh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 12:51:37 -0500
Message-ID: <41DD7A96.5060006@mtg-marinetechnik.de>
Date: Thu, 06 Jan 2005 18:51:18 +0100
From: Richard Ems <Richard.Ems@mtg-marinetechnik.de>
Organization: MTG Marinetechnik GmbH
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en, de, es
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org, Hubert Mantel <mantel@suse.de>
References: <41DD6F67.6070303@mtg-marinetechnik.de> <20050106173052.GW4597@dualathlon.random>
In-Reply-To: <20050106173052.GW4597@dualathlon.random>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Subject: Re: [PROBLEM] Badness in out_of_memory (Plain)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> On Thu, Jan 06, 2005 at 06:03:35PM +0100, Richard Ems wrote:
> 
>>Hi list, hi Mr. Mantel,
>>
>>the following "badness" happened on a SuSE 9.2 with all actual updates 
>>and SuSE's kernel 2.6.8-24.10-smp.
>>The system is a dual AMD Athlon MP 2200+ with 1GB memory and 1GB swap.
> 
> 
> This is a warning only (2.6.9 had the swap token breakage that triggered
> suprious oom kills, so the warning was meant to get more info), can you
> try with the kernel of the day?
> 
> 	http://ftp.suse.com/pub/projects/kernel/kotd/9.2-i386/SL92_BRANCH
> 
> It has my latest oom fixes that I recently posted to l-k and it should
> be very reliable for the first time in oom-killer terms.
> 
> 

I will try it tomorrow evening, it's a production system, so it's not so 
easy to "try".
How can I trigger the oom kills? I'm not sure if I can easily reproduce 
this! Do you know a memory eater program other than starting lots of 
mozilla's, OpenOffices's, etc.?

Thanks, Richard

-- 
Richard Ems
Tel: +49 40 65803 312
Fax: +49 40 65803 392
Richard.Ems@mtg-marinetechnik.de

MTG Marinetechnik GmbH - Wandsbeker Königstr. 62 - D 22041 Hamburg

GF Dipl.-Ing. Ullrich Keil
Handelsregister: Abt. B Nr. 11 500 - Amtsgericht Hamburg Abt. 66
USt.-IdNr.: DE 1186 70571

