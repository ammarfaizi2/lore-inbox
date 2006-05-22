Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750875AbWEVOmV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750875AbWEVOmV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 10:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750878AbWEVOmV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 10:42:21 -0400
Received: from mta2.cl.cam.ac.uk ([128.232.0.14]:2764 "EHLO mta2.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S1750876AbWEVOmV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 10:42:21 -0400
In-Reply-To: <4471CB54.401@tektonic.net>
References: <4468BE70.7030802@tektonic.net> <4468D613.20309@trash.net>	<44691669.4080903@tektonic.net>	<Pine.LNX.4.64.0605152331140.10964@d.namei>	<4469D84F.8080709@tektonic.net>	<Pine.LNX.4.64.0605161127030.16379@d.namei>	<446D0A0D.5090608@tektonic.net>	<Pine.LNX.4.64.0605182002330.6528@d.namei> <446D0E6D.2080600@tektonic.net> <446D151D.6030307@tektonic.net> <4470A6CD.5010501@trash.net> <4471CB54.401@tektonic.net>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <1eef85904bef8777dcf3d267ed96a942@cl.cam.ac.uk>
Content-Transfer-Encoding: 7bit
Cc: Patrick McHardy <kaber@trash.net>, James Morris <jmorris@namei.org>,
       "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>,
       Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Subject: Re: [Xen-devel] Re: Panic in ipt_do_table with 2.6.16.13-xen
Date: Mon, 22 May 2006 15:42:08 +0100
To: Matt Ayres <matta@tektonic.net>
X-Mailer: Apple Mail (2.624)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 22 May 2006, at 15:31, Matt Ayres wrote:

>> There is an identical report in the netfilter bugzilla, also crashes
>> (on x86_64) in ipt_do_table with Xen. I haven't heard anything of
>> similar crashes without Xen, so I doubt that the bug is in the
>> netfilter code.
>> https://bugzilla.netfilter.org/bugzilla/show_bug.cgi?id=478
>
> Yep... too coincidental.  I'd say it has _something_ to do with Xen. 
> I've been doing different things on my side to try to reduce the 
> severity of the problem, but I'd really like to hear what the Xen guys 
> have to say about this now..

If you can provide a vmlinux image and a backtrace we'll take a look.

  -- Keir

