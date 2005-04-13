Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261352AbVDMO0s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261352AbVDMO0s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 10:26:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261354AbVDMO0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 10:26:47 -0400
Received: from nef2.ens.fr ([129.199.96.40]:2822 "EHLO nef2.ens.fr")
	by vger.kernel.org with ESMTP id S261352AbVDMO0i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 10:26:38 -0400
Subject: Re: Exploit in 2.6 kernels
From: Eric Rannaud <eric.rannaud@ens.fr>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: John M Collins <jmc@xisl.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050413130230.GO17865@csclub.uwaterloo.ca>
References: <1113298455.16274.72.camel@caveman.xisl.com>
	 <425BBDF9.9020903@ev-en.org> <1113318034.3105.46.camel@caveman.xisl.com>
	 <20050412210857.GT11199@shell0.pdx.osdl.net>
	 <1113341579.3105.63.camel@caveman.xisl.com>
	 <20050413130230.GO17865@csclub.uwaterloo.ca>
Content-Type: text/plain
Date: Wed, 13 Apr 2005 09:26:28 -0500
Message-Id: <1113402388.5914.12.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.5.10 (nef2.ens.fr [129.199.96.32]); Wed, 13 Apr 2005 16:26:31 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-04-13 at 09:02 -0400, Lennart Sorensen wrote:
> modprobe nvidia || m-a -t prepare nvidia && m-a -t build nvidia && m-a -t install nvidia && modprobe nvidia

Something along the lines of:
modprobe nvidia || sh NVIDIA-Linux-x86-1.0-6629-pkg1.run -s -f --no-network && modprobe nvidia

should work on any distribution (it runs NVIDIA installer silently).
(see sh NVIDIA-Linux-x86-1.0-6629-pkg1.run --advanced-options)

    /er.
-- 
http://www.eleves.ens.fr/home/rannaud/

