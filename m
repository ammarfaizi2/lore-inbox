Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751572AbVJLVCw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751572AbVJLVCw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 17:02:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751575AbVJLVCw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 17:02:52 -0400
Received: from qproxy.gmail.com ([72.14.204.197]:65011 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751572AbVJLVCv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 17:02:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WnUYTu1UDnhCxGWYKvHgXRaA8ELdM7zlpVatGwxoPJ/3SgI+DrCOR5WzxnlPX+uCX827Zps02DW0WfujLF8v/T29b2X8k6HKweg4mAcypikC6AQ5Rc9XU8nsSS7DZyW+WMZcgaQKaxVyuYOTrLfGM/cLTonxzFA15OT6hFvQ3dE=
Message-ID: <5a2cf1f60510120405n6bd03776w1995bb45269b37d8@mail.gmail.com>
Date: Wed, 12 Oct 2005 13:05:19 +0200
From: jerome lacoste <jerome.lacoste@gmail.com>
To: Felix Oxley <lkml@oxley.org>
Subject: Re: Linux Kernel Dump Summit 2005
Cc: Pavel Machek <pavel@suse.cz>, OBATA Noboru <noboru.obata.ar@hitachi.com>,
       hyoshiok@miraclelinux.com, linux-kernel@vger.kernel.org
In-Reply-To: <200510121056.48429.lkml@oxley.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051010084535.GA2298@elf.ucw.cz>
	 <200510121002.59098.lkml@oxley.org>
	 <20051012090945.GN12682@elf.ucw.cz>
	 <200510121056.48429.lkml@oxley.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/05, Felix Oxley <lkml@oxley.org> wrote:
>
> Thank you for helping a clueless newbie :-)
>
> > Notice that suspend2 project actually introduced compression *for
> > speed*. Doing it right means that it is faster to do it
> > compressed.
>
> I see!
> Little benchmarks here: http://wiki.suspend2.net/BenchMarks
> shows 15% speed _increase_ with compression.

But in the LZF case, there's 100 M more memory in the cache. That
certainly has some I/O perf. impact, right?

Jerome
