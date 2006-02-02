Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750963AbWBBM1p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750963AbWBBM1p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 07:27:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750965AbWBBM1p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 07:27:45 -0500
Received: from [212.76.86.65] ([212.76.86.65]:1541 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S1750961AbWBBM1p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 07:27:45 -0500
From: Al Boldi <a1426z@gawab.com>
To: Jamie Lokier <jamie@shareable.org>
Subject: Re: [RFC] VM: I have a dream...
Date: Thu, 2 Feb 2006 15:26:08 +0300
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <200602011658.10418.a1426z@gawab.com> <20060201143840.GA19134@mail.shareable.org>
In-Reply-To: <20060201143840.GA19134@mail.shareable.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200602021526.08737.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:
> If I understand your scheme, you're suggesting the kernel accesses
> disks, filesystems, etc. by simply reading and writing somewhere in
> the 64-bit address space.
>
> At some level, that will involve page faults to move data between RAM and
> disk.
>
> Those page faults are relatively slow - governed by the CPU's page
> fault mechanism.  Probably slower than what the kernel does now:
> testing flags and indirecting through "struct page *".

Is there a way to benchmark this difference?

Thanks!

--
Al

