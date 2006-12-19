Return-Path: <linux-kernel-owner+w=401wt.eu-S932812AbWLSMKT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932812AbWLSMKT (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 07:10:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932779AbWLSMKT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 07:10:19 -0500
Received: from stinky.trash.net ([213.144.137.162]:49293 "EHLO
	stinky.trash.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932812AbWLSMKS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 07:10:18 -0500
X-Greylist: delayed 1152 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Dec 2006 07:10:18 EST
Message-ID: <4587D227.1000003@trash.net>
Date: Tue, 19 Dec 2006 12:51:03 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: Netfilter Developer Mailing List 
	<netfilter-devel@lists.netfilter.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] xt_request_find_match
References: <Pine.LNX.4.61.0612161851180.30896@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0612161851180.30896@yvahk01.tjqt.qr>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
> Reusing code is a good idea, and I would like to do so from my 
> match modules. netfilter already provides a xt_request_find_target() but 
> an xt_request_find_match() does not yet exist. This patch adds it.

Why does your match module needs to lookup other matches?

