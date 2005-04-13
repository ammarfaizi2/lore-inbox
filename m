Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261340AbVDMOld@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261340AbVDMOld (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 10:41:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261267AbVDMOlc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 10:41:32 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:26765 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S261340AbVDMOl0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 10:41:26 -0400
Date: Wed, 13 Apr 2005 10:41:26 -0400
To: Eric Rannaud <eric.rannaud@ens.fr>
Cc: John M Collins <jmc@xisl.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Exploit in 2.6 kernels
Message-ID: <20050413144126.GK521@csclub.uwaterloo.ca>
References: <1113298455.16274.72.camel@caveman.xisl.com> <425BBDF9.9020903@ev-en.org> <1113318034.3105.46.camel@caveman.xisl.com> <20050412210857.GT11199@shell0.pdx.osdl.net> <1113341579.3105.63.camel@caveman.xisl.com> <20050413130230.GO17865@csclub.uwaterloo.ca> <1113402388.5914.12.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1113402388.5914.12.camel@localhost>
User-Agent: Mutt/1.3.28i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2005 at 09:26:28AM -0500, Eric Rannaud wrote:
> On Wed, 2005-04-13 at 09:02 -0400, Lennart Sorensen wrote:
> > modprobe nvidia || m-a -t prepare nvidia && m-a -t build nvidia && m-a -t install nvidia && modprobe nvidia
> 
> Something along the lines of:
> modprobe nvidia || sh NVIDIA-Linux-x86-1.0-6629-pkg1.run -s -f --no-network && modprobe nvidia
> 
> should work on any distribution (it runs NVIDIA installer silently).
> (see sh NVIDIA-Linux-x86-1.0-6629-pkg1.run --advanced-options)

It will work on most.  Some don't like where the nvidia installer dumps
it files in some cases.  Certainly doesn't work on every amd64 system
since they can't agree where 64bit libs should go yet.

It also violates my principles more than using binary only drivers does.
All files in /usr (except /usr/local) _must_ be installed by one package
management tool.  No excaptions allowed.  I haven't had to reinstall for
6 years, so I am sticking with my principles.

Len Sorensen
