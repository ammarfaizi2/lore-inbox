Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265371AbUAHRT6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 12:19:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265555AbUAHRT6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 12:19:58 -0500
Received: from intra.cyclades.com ([64.186.161.6]:42732 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S265371AbUAHRTz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 12:19:55 -0500
Date: Thu, 8 Jan 2004 15:10:05 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: martin f krafft <madduck@madduck.net>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: stability problems with 2.4.24/Software RAID/ext3
In-Reply-To: <Pine.LNX.4.58L.0401081452490.30956@logos.cnet>
Message-ID: <Pine.LNX.4.58L.0401081508290.30956@logos.cnet>
References: <20040108151225.GA11740@piper.madduck.net>
 <Pine.LNX.4.58L.0401081452490.30956@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 8 Jan 2004, Marcelo Tosatti wrote:

> > Apart from these panics and hangups, the system also randomly issues
> > segfaults to processes, or reports a kernel oops. These take the
> > following form:
>
> Hi Martin,
>
> I can't help you much, but I believe your problem might be related to
> faulty hardware. Have you checked if the memory OK ?
>
> Try disabling DMA on the Promise?

More information (/proc/mtrr, /proc/interrupts, dmesg, etc) is helpful.
