Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261313AbVFOLlR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261313AbVFOLlR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 07:41:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261384AbVFOLlR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 07:41:17 -0400
Received: from mx1.redhat.com ([66.187.233.31]:10474 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261313AbVFOLgh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 07:36:37 -0400
Message-ID: <42B0127A.4000309@sgi.com>
Date: Wed, 15 Jun 2005 07:35:22 -0400
From: Prarit Bhargava <prarit@sgi.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Pozs=E1r_Bal=E1zs?= <pozsy@uhulinux.hu>
CC: Steve Lord <lord@xfs.org>, "K.R. Foley" <kr@cybsft.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       rusty@rustcorp.com.au
Subject: Re: Race condition in module load causing undefined symbols
References: <42AB25E7.5000405@xfs.org> <20050611120040.084942ed.akpm@osdl.org> <42AEDCFB.8080002@xfs.org> <42AEF979.2000207@cybsft.com> <42AF080A.1000307@xfs.org> <42AF0FA2.2050407@cybsft.com> <42AF165E.1020702@xfs.org> <42AF2088.3090605@sgi.com> <20050614205933.GC7082@ojjektum.uhulinux.hu> <42B010C0.90707@sgi.com> <20050615113423.GF20567@ojjektum.uhulinux.hu>
In-Reply-To: <20050615113423.GF20567@ojjektum.uhulinux.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pozsár Balázs wrote:

>>If you're using bash, I would suggest starting with an update of the bash 
>>package.
> 
> 
> Well, I'm using 3.0 and afaik there's no newer version, but I don't 
> think this is the problem either.
> 
> Exactlywhat modifications have to be made and to what to work around 
> this kernel regression?
> 

Just to be clear, this isn't a kernel regression -- it's a problem with packages ;).

Try backing out the patch I pointed to earlier in the thread.  Let's see if that 
works...

P.

