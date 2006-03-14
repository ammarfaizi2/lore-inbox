Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932457AbWCNVMh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932457AbWCNVMh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 16:12:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932458AbWCNVMh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 16:12:37 -0500
Received: from mta07-winn.ispmail.ntl.com ([81.103.221.47]:64630 "EHLO
	mtaout01-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S932457AbWCNVMg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 16:12:36 -0500
Message-ID: <441733C0.5040605@gentoo.org>
Date: Tue, 14 Mar 2006 21:21:04 +0000
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mail/News 1.5 (X11/20060207)
MIME-Version: 1.0
To: Trond Myklebust <Trond.Myklebust@netapp.com>
CC: Jan Engelhardt <jengelh@linux01.gwdg.de>, neilb@cse.unsw.edu.au,
       nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       okir@monad.swb.de
Subject: Re: [PATCH] sunrpc svc: be quieter
References: <20060305005532.5E7A0870504@zog.reactivated.net>	 <Pine.LNX.4.61.0603051451590.30115@yvahk01.tjqt.qr> <1141678330.31680.13.camel@lade.trondhjem.org>
In-Reply-To: <1141678330.31680.13.camel@lade.trondhjem.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond,

Trond Myklebust wrote:
> They are probably trying to ping the server with a NULL procedure call
> to test for service availability. We should allow that particular
> usage...

Thanks, that sounds likely. Can you give some hints as to how a NULL 
procedure call might appear? Would testing for prog==0 and/or proc==0 be 
appropriate?

Daniel
