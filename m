Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261398AbVAXAsr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261398AbVAXAsr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 19:48:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261399AbVAXAsr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 19:48:47 -0500
Received: from lakermmtao07.cox.net ([68.230.240.32]:4264 "EHLO
	lakermmtao07.cox.net") by vger.kernel.org with ESMTP
	id S261398AbVAXApV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 19:45:21 -0500
In-Reply-To: <4EE0CBA31942E547B99B3D4BFAB348112B93D8@mail.esn.co.in>
References: <4EE0CBA31942E547B99B3D4BFAB348112B93D8@mail.esn.co.in>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <3708059A-6DA1-11D9-A93E-000393ACC76E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel-Mailing-list <linux-kernel@vger.kernel.org>
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: FATAL: Error inserting fm -- invalid module format
Date: Sun, 23 Jan 2005 19:45:16 -0500
To: "Srinivas G." <srinivasg@esntechnologies.co.in>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 21, 2005, at 09:08, Srinivas G. wrote:
> FATAL: Error inserting fm
> (/lib/modules/2.6.4-52-default/kernel/drivers/block/fm.ko): Invalid
> module format
>
> As I know the error message indicates that I compiled the driver under
> 2.6.5-7.71 kernel where as I am trying to insert the module in
> 2.6.4-52-default kernel.
>
> My question is: Is it possible to compile and build a .ko file with out
> including the version information? (i.e. I want to build a RPM file
> using fm.ko file which was compiled using 2.6.5-7.71 and to run the RPM
> file on a different kernel versions.)

This message means that if you load your module it is guaranteed to 
cause
a crash because it is the wrong version.  It would be best if you could
license your source code under the GPL and publish a set of small 
discreet
patches to the stock kernel to this list.  That way it would be included
and maintained across API revisions for you by the community.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


