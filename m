Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965203AbWEZAsY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965203AbWEZAsY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 20:48:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965204AbWEZAsY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 20:48:24 -0400
Received: from vms040pub.verizon.net ([206.46.252.40]:38530 "EHLO
	vms040pub.verizon.net") by vger.kernel.org with ESMTP
	id S965203AbWEZAsX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 20:48:23 -0400
Date: Thu, 25 May 2006 20:48:16 -0400
From: Michael Stone <mstone@mathom.us>
Subject: Re: [PATCH 00/33] Adaptive read-ahead V12
In-reply-to: <20060525150149.666c8476.akpm@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: David Lang <dlang@digitalinsight.com>, wfg@mail.ustc.edu.cn,
       linux-kernel@vger.kernel.org
Message-id: <20060526004814.GC27471@mathom.us>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-disposition: inline
X-Pgp-Fingerprint: 53 FF 38 00 E7 DD 0A 9C  84 52 84 C5 EE DF 7C 88
References: <348469535.17438@ustc.edu.cn>
 <20060525084415.3a23e466.akpm@osdl.org>
 <Pine.LNX.4.63.0605251240160.1814@dlang.diginsite.com>
 <20060525150149.666c8476.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2006 at 03:01:49PM -0700, Andrew Morton wrote:
>If the developers of that program want to squeeze the last 5% out of it
>then sure, I'd expect them to use such OS-provided I/O scheduling
>facilities.  

Maybe, if we were talking about squeezing the last 5%. But all 
applications should be required to greatly complicate their IO routines 
for the last 30%? To reimplement something the kernel already does (at 
least to some degree), as opposed to making the kernel implementation 
better? "Is that dumb, or what?" :-)

>Database developers do that sort of thing all the time.

Even the oracle people seem to have figured out they were doing too much 
that's properly the responsibility of the OS and creating a maintenance 
and portability nightmare. 

Mike Stone
