Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264147AbUFVRId@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264147AbUFVRId (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 13:08:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264058AbUFVRHC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 13:07:02 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:8875 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S264492AbUFVQsP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 12:48:15 -0400
Message-ID: <40D862CA.4050703@opensound.com>
Date: Tue, 22 Jun 2004 09:48:10 -0700
From: 4Front Technologies <dev@opensound.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
CC: Hannu Savolainen <hannu@opensound.com>, Andrea Arcangeli <andrea@suse.de>,
       David Lang <david.lang@digitalinsight.com>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
Subject: Re: Stop the Linux kernel madness
References: <40D232AD.4020708@opensound.com> <20040622020615.GE14478@dualathlon.random> <Pine.LNX.4.58.0406221033350.8222@zeus.compusonic.fi> <200406221419.46035.vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200406221419.46035.vda@port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko wrote:

> On Tuesday 22 June 2004 10:54, Hannu Savolainen wrote:
> 
>>In the long term frequent changes in kernel interfaces cause problems
>>because drivers that try to stay compatible with as many kernel versions
>>as possible will start looking like #ifdef spaghetti.
> 
> 
> What's the point in staying "compatible with as many kernels versions
> as possible"? IMHO it's enough to be able to build and work
> with latest 2.6, latest 2.4 and maybe latest 2.2. Not _that_
> much of #ifdefs.
> 
> (/me was looking into ntp code recently. *That* is #ifdef hell)
> --
> vda
> 

Hi Denis,

You'd be surprised how many people are still running Redhat 7.3 or howmany 
people are still running some version of Linux 2.4.2x. Sometimes its not easy 
telling the customer to upgrade to the latest Linux kernel from www.kernel.org 
because they don't have the expertise to compile kernels - heck some 
distributions don't even install gcc/make unless you select "Development System" 
during installation. (FreeBSD is more sane in that regard that they install 
gcc/make with the base system).


best regards
Dev Mazumdar

-- 
-----------------------------------------------------------
4Front Technologies
4035 Lafayette Place, Unit F, Culver City, CA 90232, USA.
Tel: (310) 202 8530		URL: www.opensound.com
Fax: (310) 202 0496 		Email: info@opensound.com
-----------------------------------------------------------
