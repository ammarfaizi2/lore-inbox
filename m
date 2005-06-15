Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261379AbVFOMcb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261379AbVFOMcb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 08:32:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261434AbVFOMcb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 08:32:31 -0400
Received: from relay02.roc.ny.frontiernet.net ([66.133.182.165]:1936 "EHLO
	relay02.roc.ny.frontiernet.net") by vger.kernel.org with ESMTP
	id S261379AbVFOMc1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 08:32:27 -0400
Message-ID: <42B02004.6020306@xfs.org>
Date: Wed, 15 Jun 2005 07:33:08 -0500
From: Stephen Lord <lord@xfs.org>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.3 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Prarit Bhargava <prarit@sgi.com>
Cc: =?ISO-8859-1?Q?Pozs=E1r_Bal=E1zs?= <pozsy@uhulinux.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: Race condition in module load causing undefined symbols
References: <42AAE5C8.9060609@xfs.org> <20050611150525.GI17639@ojjektum.uhulinux.hu> <42AB25E7.5000405@xfs.org> <20050611120040.084942ed.akpm@osdl.org> <42AEDCFB.8080002@xfs.org> <42AEF979.2000207@cybsft.com> <42AF080A.1000307@xfs.org> <42AF0FA2.2050407@cybsft.com> <42AF165E.1020702@xfs.org> <42AF2088.3090605@sgi.com> <20050614205933.GC7082@ojjektum.uhulinux.hu> <42B010C0.90707@sgi.com>
In-Reply-To: <42B010C0.90707@sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Prarit Bhargava wrote:
> 
> If you're using bash, I would suggest starting with an update of the 
> bash package.
> 
> It's interesting to note that Steve also needed to update his udev 
> package. Steve, IIRC you were using Fedora 3/4?
> 
> P.
> 

I am running an updated Fedora Core 3 - on both machines which have the
problem. I used rpms from Fedora Core 4 to update the system, this led
to a chain of updates, mkinitrd, udev, initscripts and a few others
with cross dependencies.

Still puzzled about what could have been fixed in user space since this
appears to affect more than one shell. Module loading appears to be
very synchronous, so unless the shell was not waiting for exit status
on children correctly, it seems hard to explain in user space.

Steve


