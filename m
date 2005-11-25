Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161100AbVKYPbs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161100AbVKYPbs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 10:31:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161109AbVKYPbr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 10:31:47 -0500
Received: from gw1.cosmosbay.com ([62.23.185.226]:10709 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S1161100AbVKYPbr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 10:31:47 -0500
Message-ID: <43872E5A.3030103@cosmosbay.com>
Date: Fri, 25 Nov 2005 16:31:38 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Eric Dumazet <dada1@cosmosbay.com>
CC: Wu Fengguang <wfg@mail.ustc.edu.cn>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 10/19] readahead: state based method
References: <20051125151210.993109000@localhost.localdomain> <20051125151550.440541000@localhost.localdomain> <43872BF2.3030407@cosmosbay.com>
In-Reply-To: <43872BF2.3030407@cosmosbay.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Fri, 25 Nov 2005 16:31:36 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Dumazet a écrit :

> Hum... This sizeof(struct file) increase seems quite large...
> 
> Have you ever considered to change struct file so that file_ra_state is 
> not embedded, but dynamically allocated (or other strategy) for regular 
> files ?
> 
> I mean, sockets, pipes cannot readahead... And some machines use far 
> more sockets than regular files.
> 
> I wrote such a patch in the past I could resend...

http://marc.theaimsgroup.com/?l=linux-kernel&m=112435605407020&w=2

