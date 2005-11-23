Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932467AbVKWVOk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932467AbVKWVOk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 16:14:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932466AbVKWVOk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 16:14:40 -0500
Received: from atlrel6.hp.com ([156.153.255.205]:65231 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S932458AbVKWVOK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 16:14:10 -0500
Date: Wed, 23 Nov 2005 13:13:37 -0800
From: Stephane Eranian <eranian@hpl.hp.com>
To: linux-kernel@vger.kernel.org
Cc: Stephane Eranian <eranian@hpl.hp.com>
Subject: [PATCH 1/5] common perfmon2 code for review
Message-ID: <20051123211337.GB18563@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <20051118170055.GF30262@frankl.hpl.hp.com> <20051123145308.GB17228@frankl.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051123145308.GB17228@frankl.hpl.hp.com>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello again,

Due to the message size limit on this list. Part 1 and 2 got blocked.
Unfortunately the common code patch cannot easily be split into
chunks of less than 100KB, The core file which is entirely new is
120KB by itself.

As a consequence, I strongly suggest that people interested in
reviewing the code go the web site below to download the kernel patch.

Thanks.

On Wed, Nov 23, 2005 at 06:53:08AM -0800, Stephane Eranian wrote:
> 
> For some reasons, the original annoucement from 11/18
> for this release never made it to this list.
> 
> You can download the latest packages from:
> 
> 	http://www.sf.net/projects/perfmon2
> 
> You need to grab:
> 	2.6.15-rc1-git6 (kernel code)
> 	libpfm-3.2-051118 (user library)
> 
> 
> For convenience, I am also posting the patch directly
> to the list. At this point, the patch is for review.
> Please cc me on your replies because due to the volume
> of traffic I am not a member of the list.
> 
> I have split the patch into 5 parts. The first part is needed on
> each platform (common code). All the others are specific to
> a processor architecture. There is an exception for x86-64 which
> needs the i386 portion due to cross use of header files. The
> patch is relative to 2.6.15-rc1-git6.
> 
> thanks.
