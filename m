Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751423AbWEDHai@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751423AbWEDHai (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 03:30:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751428AbWEDHai
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 03:30:38 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:45801 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S1751423AbWEDHah (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 03:30:37 -0400
Date: Thu, 4 May 2006 09:30:35 +0200
From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: linux-kernel@vger.kernel.org, nils@kernelconcepts.de
Subject: Re: i8xx TCO timer: does not reset my machine
Message-ID: <20060504073035.GB18695@cip.informatik.uni-erlangen.de>
Mail-Followup-To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	"Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org,
	nils@kernelconcepts.de
References: <20060501225948.GM1487@cip.informatik.uni-erlangen.de> <20060503163207.aac77d39.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="17pEHd4RhPHOinZp"
Content-Disposition: inline
In-Reply-To: <20060503163207.aac77d39.rdunlap@xenotime.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Randy,
thanks for the reply, but the problem isn't how I tried to trigger it
from the userland but how the new chips work. See attached eMail.
Nevertheless at the moment the software watchdog is okay with me. But
the userland 'watchdog' programm is driving me crazy. 6 false positives
in less than 48 hours which resulted into reboots. I think that I will
put some work into writing something more reliable.

        Thomas

--17pEHd4RhPHOinZp
Content-Type: message/rfc822
Content-Disposition: inline

Return-Path: <wim@iguana.be>
X-Spam-Checker-Version: SpamAssassin 3.1.1 (2006-03-10) on 
	faui03.informatik.uni-erlangen.de
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,FORGED_RCVD_HELO 
	autolearn=ham version=3.1.1
X-Original-To: sithglan@stud.informatik.uni-erlangen.de
Delivered-To: sithglan@stud.informatik.uni-erlangen.de
Received: from max71.rrze.uni-erlangen.de (max71.rrze.uni-erlangen.de [131.188.3.181])
	by faui03.informatik.uni-erlangen.de (Postfix) with ESMTP id DE7A33060F
	for <sithglan@stud.informatik.uni-erlangen.de>; Wed,  3 May 2006 20:38:59 +0200 (CEST)
Received: from fau-vscan-1.rrze.uni-erlangen.de ([131.188.3.181] [131.188.3.181]) by faurelaysmart-1.rrze.uni-erlangen.de with ESMTP for sithglan@stud.uni-erlangen.de; Wed, 3 May 2006 20:38:43 +0200
Received: from max71.rrze.uni-erlangen.de ([131.188.3.181])
 by fau-vscan-1.rrze.uni-erlangen.de (fau-vscan-1.rrze.uni-erlangen.de [131.188.2.91]) (amavisd-new)
 with ESMTP id 06883-09-22 for <sithglan@stud.uni-erlangen.de>;
 Wed,  3 May 2006 20:38:43 +0200 (MEST)
Received: from outfbmx007.isp.belgacom.be (outfbmx007.isp.belgacom.be [195.238.5.104]) by faurelayrz-1.rrze.uni-erlangen.de with ESMTP for sithglan@stud.uni-erlangen.de; Wed, 3 May 2006 20:38:42 +0200
Received: from outmx025.isp.belgacom.be (outmx025.isp.belgacom.be [195.238.4.49])
	by outfbmx007.isp.belgacom.be (Postfix) with ESMTP id 46E36395C6
	for <sithglan@stud.uni-erlangen.de>; Wed,  3 May 2006 20:08:11 +0200 (CEST)
Received: from outmx025.isp.belgacom.be (localhost [127.0.0.1])
        by outmx025.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22) with ESMTP id k43I7vLK031063
        for <sithglan@stud.uni-erlangen.de>; Wed, 3 May 2006 20:07:57 +0200
        (envelope-from <wim@iguana.be>)
Received: from infomag.iguana.be (103.146-136-217.adsl.skynet.be [217.136.146.103])
        by outmx025.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22) with ESMTP id k43I7nHQ030967
        for <sithglan@stud.uni-erlangen.de>; Wed, 3 May 2006 20:07:49 +0200
        (envelope-from <wim@iguana.be>)
Received: from infomag.iguana.be (localhost.localdomain [127.0.0.1])
	by infomag.iguana.be (8.13.1/8.12.11) with ESMTP id k43I7nG9004380
	for <sithglan@stud.uni-erlangen.de>; Wed, 3 May 2006 20:07:49 +0200
Received: (from wim@localhost)
	by infomag.iguana.be (8.13.1/8.13.1/Submit) id k43I7nid004379
	for sithglan@stud.uni-erlangen.de; Wed, 3 May 2006 20:07:49 +0200
Date: Wed, 3 May 2006 20:07:49 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: Re: i8xx TCO timer: does not reset my machine
Message-Id: <20060503180749.GA4203@infomag.infomag.iguana.be>
References: <20060502135230.GD16099@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060502135230.GD16099@cip.informatik.uni-erlangen.de>
User-Agent: Mutt/1.4.1i
X-Virus-Scanned: by amavisd-new-20030616 (RRZE) on max71.rrze.uni-erlangen.de

Hi Thomas,

> 
>            [ I wrote you this in case you missed it on LKML ]
> 
> I have one additional question. Might it be possible that the
> southbridge does support the watchdog but isn't wired to actually do the
> reset or is this a sofware problem in the driver?
> 
> I have an Intel board (D915GEV/D915GRF) with an onboard i8xx TCO timer
> watchdog on it. I compiled a kernel and tried to make it reset my
> machine, but it simply doesn't. I use Linus Linux tree (GIT HEAD), the
> following watchdog related configuration:

Intel changed the way the ICH6 & ICH7 work. I have new code for this
and since yesterday evening an intel motherboard to test it with.
Update will follow... Bug is open for it on bug.kernel.org.

Greetings,
Wim.


--17pEHd4RhPHOinZp--
