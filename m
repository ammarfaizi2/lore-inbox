Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315630AbSG1J4G>; Sun, 28 Jul 2002 05:56:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315631AbSG1J4F>; Sun, 28 Jul 2002 05:56:05 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:29188 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S315630AbSG1J4F>; Sun, 28 Jul 2002 05:56:05 -0400
Date: Sun, 28 Jul 2002 10:59:17 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Federico Sevilla III <jijo@free.net.ph>
Cc: Linux-XFS Mailing List <linux-xfs@oss.sgi.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel BUG at page_alloc.c:91 (2.4.19-rc2-xfs)
Message-ID: <20020728105917.A6391@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Federico Sevilla III <jijo@free.net.ph>,
	Linux-XFS Mailing List <linux-xfs@oss.sgi.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20020728082542.GC1265@leathercollection.ph>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020728082542.GC1265@leathercollection.ph>; from jijo@free.net.ph on Sun, Jul 28, 2002 at 04:25:42PM +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 28, 2002 at 04:25:42PM +0800, Federico Sevilla III wrote:
> Hi everyone,
> 
> I apologize for sending this to both the Linux kernel mailing list as
> well as the Linux-XFS mailing list. I am sending this to the lkml
> because it's a kernel bug report. I'm sending this to the Linux-XFS
> mailing list because I do not know if "try_to_free_buffers+130/240" in
> the Call Trace has anything to do with changes that the XFS team has
> done on the Linux kernel.

Let me guess: you're using nvidia's binary only module?  if so please go
and complain to them, this oops is characteristic for their buggy driver.

