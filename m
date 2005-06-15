Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261338AbVFOLac@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261338AbVFOLac (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 07:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261422AbVFOL32
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 07:29:28 -0400
Received: from mx1.redhat.com ([66.187.233.31]:30437 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261419AbVFOL3T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 07:29:19 -0400
Message-ID: <42B010C0.90707@sgi.com>
Date: Wed, 15 Jun 2005 07:28:00 -0400
From: Prarit Bhargava <prarit@sgi.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Pozs=E1r_Bal=E1zs?= <pozsy@uhulinux.hu>
CC: Steve Lord <lord@xfs.org>, "K.R. Foley" <kr@cybsft.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       rusty@rustcorp.com.au
Subject: Re: Race condition in module load causing undefined symbols
References: <42AAE5C8.9060609@xfs.org> <20050611150525.GI17639@ojjektum.uhulinux.hu> <42AB25E7.5000405@xfs.org> <20050611120040.084942ed.akpm@osdl.org> <42AEDCFB.8080002@xfs.org> <42AEF979.2000207@cybsft.com> <42AF080A.1000307@xfs.org> <42AF0FA2.2050407@cybsft.com> <42AF165E.1020702@xfs.org> <42AF2088.3090605@sgi.com> <20050614205933.GC7082@ojjektum.uhulinux.hu>
In-Reply-To: <20050614205933.GC7082@ojjektum.uhulinux.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pozsár Balázs wrote:
> On Tue, Jun 14, 2005 at 02:23:04PM -0400, Prarit Bhargava wrote:
> 
>>The second fix, and again you must do this if you're developing 2.6.12, is 
>>to *update the mkinitrd package* which has a new version of /bin/sh.
> 
> 
> This sounds insane to me. I am using bash in my initrd, does this mean 
> that every shell and whatever has to be updated? Exactly what 
> modifications has to be made?
> 
> 

If you're using bash, I would suggest starting with an update of the bash package.

It's interesting to note that Steve also needed to update his udev package. 
Steve, IIRC you were using Fedora 3/4?

P.
