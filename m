Return-Path: <linux-kernel-owner+w=401wt.eu-S964928AbWLTIQ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964928AbWLTIQ5 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 03:16:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964929AbWLTIQ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 03:16:57 -0500
Received: from stinky.trash.net ([213.144.137.162]:36853 "EHLO
	stinky.trash.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964928AbWLTIQ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 03:16:56 -0500
Message-ID: <4588F175.8060109@trash.net>
Date: Wed, 20 Dec 2006 09:16:53 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: Netfilter Developer Mailing List 
	<netfilter-devel@lists.netfilter.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] xt_request_find_match
References: <Pine.LNX.4.61.0612161851180.30896@yvahk01.tjqt.qr> <4587D227.1000003@trash.net> <Pine.LNX.4.61.0612191405160.24179@yvahk01.tjqt.qr> <4587E91A.2020903@trash.net> <Pine.LNX.4.61.0612191623490.10396@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0612191623490.10396@yvahk01.tjqt.qr>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
> [...]
>
> Ok, but let's say I wanted to use a bigger match module (layer7, anyone?)
> Then it's just not if(protocol == IPPROTO_TCP). What's the preferred solution
> then?

Make sure the user specifies the match on the command line before
your match. Look at the TCPMSS or REJECT targets for examples for
this.

