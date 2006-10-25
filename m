Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964796AbWJYPoZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964796AbWJYPoZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 11:44:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751870AbWJYPoZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 11:44:25 -0400
Received: from terminus.zytor.com ([192.83.249.54]:46813 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751706AbWJYPoY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 11:44:24 -0400
Message-ID: <453F8630.2000608@zytor.com>
Date: Wed, 25 Oct 2006 08:43:44 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Jes Sorensen <jes@sgi.com>, Junio C Hamano <junkio@cox.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [git failure] failure pulling latest Linus tree
References: <yq0d58g92u0.fsf@jaguar.mkp.net> <Pine.LNX.4.64.0610250746000.3962@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610250746000.3962@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Wed, 25 Oct 2006, Jes Sorensen wrote:
>> Known error? git tree corrupted or need for a new version of git?
> 
> For some reason, the mirroring seems to be really slow or broken to one of 
> the public servers (zeus-pub1). It looks to be affecting gitweb too (ie 
> www1.kernel.org is busted, while www2.kernel.org seems ok)
> 

For some reason which we haven't been able to track down yet, the recent 
load imposed by FC6 caused zeus1's load to skyrocket, but not zeus2's... 
it's largely a mystery.

HOWEVER, git 1.4.3 seems to have been bad chicken.  When we ran it we 
got a neverending stream of segfaults in the logs.

	-hpa
