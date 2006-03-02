Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751305AbWCBDLI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305AbWCBDLI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 22:11:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751392AbWCBDLH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 22:11:07 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:48522 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751305AbWCBDLG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 22:11:06 -0500
Date: Wed, 1 Mar 2006 19:10:29 -0800
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: laurent.riffard@free.fr, jesper.juhl@gmail.com,
       linux-kernel@vger.kernel.org, rjw@sisk.pl, mbligh@mbligh.org,
       clameter@engr.sgi.com, ebiederm@xmission.com
Subject: Re: 2.6.16-rc5-mm1
Message-Id: <20060301191029.108be72e.pj@sgi.com>
In-Reply-To: <20060301023235.735c8c47.akpm@osdl.org>
References: <20060228042439.43e6ef41.akpm@osdl.org>
	<9a8748490602281313t4106dcccl982dc2966b95e0a7@mail.gmail.com>
	<4404CE39.6000109@liberouter.org>
	<9a8748490602281430x736eddf9l98e0de201b14940a@mail.gmail.com>
	<4404DA29.7070902@free.fr>
	<20060228162157.0ed55ce6.akpm@osdl.org>
	<4405723E.5060606@free.fr>
	<20060301023235.735c8c47.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew wrote:
> If you have (even more) time you could test
> http://www.zip.com.au/~akpm/linux/patches/stuff/2.6.16-rc5-mm2-pre1.gz. 
> That's the latest of everything with the problematic sysfs patches reverted
> and Eric's recent /proc fixes.

I tested both the fuser command that had been crashing the earlier
kernels with Eric's /proc patches, and my "SGI internal software
management" application, on which I first saw these kernels fail.

With this 2.6.16-rc5-mm2-pre1 kernel, they both work - no more crash.

Good.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
