Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262591AbTJNOQ0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 10:16:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262592AbTJNOQ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 10:16:26 -0400
Received: from intra.cyclades.com ([64.186.161.6]:3292 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S262591AbTJNOQY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 10:16:24 -0400
Date: Tue, 14 Oct 2003 11:19:20 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Ivo Santos Cavalcante Carneiro <iscc@gawab.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: scsi emulation error
In-Reply-To: <3F890894.7080200@gawab.com>
Message-ID: <Pine.LNX.4.44.0310141118380.2790-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 12 Oct 2003, Ivo Santos Cavalcante Carneiro wrote:

> I'm unable to mount cdrom on my system when using ide-scsi. Using 
> ide-cdrom works fine. I first saw this problem on 2.4.21. I'm using 
> 2.4.22, tested 2.4.23-pre7 and the problem exist yet. This is a short 
> description of the system:
> 
> asus A7V8X-X mobo
> LG CD-ROM CRD-8400B (rev. 1.08)
> kernel 2.4.22 on Debian Woody
> 
> 
> These are the error messages took from kernel log:
> ]
> ide-scsi: expected 2048 got 4096 limit 2048
> ide-scsi: The scsi wants to send us more data than expected - discarding 
> data
> ide-scsi: [[ 28 0 0 0 0 5f 0 0 1 0 0 0 ]
> ]
> ide-scsi: expected 2048 got 4096 limit 2048
> ide-scsi: The scsi wants to send us more data than expected - discarding 
> data
> ide-scsi: [[ 28 0 0 0 0 60 0 0 1 0 0 0 ]
> ]
> ide-scsi: expected 2048 got 4096 limit 2048
> ide-scsi: The scsi wants to send us more data than expected - discarding 
> data
> ide-scsi: [[ 28 0 0 0 0 61 0 0 1 0 0 0 ]
> ]
> 
> ...  many times, and then:
> 
> ide-scsi: expected 2048 got 4096 limit 2048
> Unable to identify CD-ROM format.

Ivo, 

Can you try 2.4.20 and see if that works? 

