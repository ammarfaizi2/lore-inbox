Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262008AbTEHTen (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 15:34:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262023AbTEHTem
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 15:34:42 -0400
Received: from siaag1ae.compuserve.com ([149.174.40.7]:27880 "EHLO
	siaag1ae.compuserve.com") by vger.kernel.org with ESMTP
	id S262008AbTEHTeW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 15:34:22 -0400
Date: Thu, 8 May 2003 15:43:37 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: The disappearing sys_call_table export.
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200305081546_MC3-1-3809-363D@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> you can write a stackable filesystem on linux, too and intercept any
> I/O request.  You just have to do it through a sane interface, mount
> and not by patching the syscall table - which you can do under
> windows either.  (at least not as part of the public API).

  So when I register my filesystem, can I indicate that I want to be
layered over top of the ext3 driver and get control anytime someone
mounts an ext3 fileystem, so I can decide whether the volume being
mounted is one that I want to intercept open/read/write requests for?


