Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264013AbTJOSzg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 14:55:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264075AbTJOSyq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 14:54:46 -0400
Received: from mauve.demon.co.uk ([158.152.209.66]:6855 "EHLO
	mauve.demon.co.uk") by vger.kernel.org with ESMTP id S264056AbTJOSxb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 14:53:31 -0400
From: root@mauve.demon.co.uk
Message-Id: <200310151854.TAA09370@mauve.demon.co.uk>
Subject: Re: Transparent compression in the FS
To: Nikita@Namesys.COM (Nikita Danilov)
Date: Wed, 15 Oct 2003 19:54:22 +0100 (BST)
Cc: erik@harddisk-recovery.com (Erik Mouw), josh@temp123.org (Josh Litherland),
       linux-kernel@vger.kernel.org
In-Reply-To: <16269.23199.833564.163986@laputa.namesys.com> from "Nikita Danilov" at Oct 15, 2003 06:33:03 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Erik Mouw writes:
>  > On Wed, Oct 15, 2003 at 05:50:38PM +0400, Nikita Danilov wrote:
>  > > Erik Mouw writes:
>  > >  > Nowadays disks are so incredibly cheap, that transparent compression
>  > >  > support is not realy worth it anymore (IMHO).
<snip>
>  > You have a point, but remember that modern IDE drives can do about
>  > 50MB/s from medium. I don't think you'll find a CPU that is able to
>  > handle transparent decompression on the fly at 50MB/s, even not with a
>  > simple compression scheme as used in NTFS (see the NTFS docs on
>  > SourceForge for details).

I haven't got the original message (mail problems) so I'm responding here.

I misread your message, and thought you said compression.
My Duron 1300 (hardly the fastest machine) compresses (gzip -1) at around
40Mb/sec (repetitive log-files that compress to 5% using gzip -1) and 
10Mb/sec on text (compressing to 40%).

On expansion, it decompresses compressed text at around 14Mb/sec (resulting
in 30Mb/sec, around my disk speed), and logfiles at 110Mb/sec, which is 
significantly faster.

This is with a single stick of PC133 RAM, and a tiny 64K cache.
I would be very surprised if even a high end consumer machine couldn't handle
50Mb/sec.
