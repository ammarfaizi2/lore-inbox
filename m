Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263222AbTJPXjS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 19:39:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263224AbTJPXjS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 19:39:18 -0400
Received: from mout1.freenet.de ([194.97.50.132]:46244 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id S263222AbTJPXjO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 19:39:14 -0400
From: Andreas Hartmann <andihartmann@freenet.de>
X-Newsgroups: fa.linux.kernel
Subject: Re: 2.4.23-pre VM regression?
Date: Fri, 17 Oct 2003 01:37:49 +0200
Organization: privat
Message-ID: <bmna4e$4bi$1@ID-44327.news.dfncis.de>
References: <fa.jkt135h.1l0s0t@ifi.uio.no> <fa.j3l9liv.1djudhj@ifi.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
X-Trace: susi.maya.org 1066347470 4466 192.168.1.3 (16 Oct 2003 23:37:50 GMT)
X-Complaints-To: abuse@fu-berlin.de
User-Agent: KNode/0.7.6
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
X-MIME-Autoconverted: from 8bit to quoted-printable by susi.maya.org id h9GNd9cq004642
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tvrtko A. Ur¨ulin wrote:

> 
>> So a lot of processes which should not get killed are dying. This is
>> really bad. I was afraid it could happen and it did.
>>
>> What now? Resurrect OOM-killer?
> 
> Regards to all,
> 
> It seems that this topic is very persistent. I have RFC-ed this patch
> (attached) a few days and here it goes again.
> 
> It makes OOM Killer a compile time option (IMHO better than completely
> remove or fixed-include it). Even, more, it makes it completely modular
> and adds two new killers.
> 
> Any comments?

I think it would be good to have it as option. Maybe there are situations,
where the old model is better then the new one.

But let me say, that the OOM Killer has its problems too: I often saw
servers with killed sshd or apache, named, ... instead of the bad
rsync-process, which eats up all the memory ressources until the OOM killer
killed it.

Onother thing:
the new VM is the best VM I ever saw in a 2.4.x kernel. On the desktop with
512 MB RAM and used 230MB swap and 14MB/s HD i/o (IDE) and KDE compiling
(load about 3), I was able to look mpeg's without any problem.


Kind regards,
Andreas Hartmann
