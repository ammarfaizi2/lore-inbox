Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030342AbWJPKPU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030342AbWJPKPU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 06:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030345AbWJPKPU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 06:15:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:28095 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030342AbWJPKPT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 06:15:19 -0400
From: Andi Kleen <ak@suse.de>
To: Dave Jones <davej@redhat.com>
Subject: Re: Compress stack unwinder output
Date: Mon, 16 Oct 2006 12:03:27 +0200
User-Agent: KMail/1.9.3
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
References: <20061006215412.GB15420@redhat.com>
In-Reply-To: <20061006215412.GB15420@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610161203.27246.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 06 October 2006 23:54, Dave Jones wrote:
> The unwinder has some extra newlines, which eat up loads of screen
> space when it spews. (See https://bugzilla.redhat.com/bugzilla/attachment.cgi?id=137900
> for a nasty example).
> 
> warning_symbol-> and warning-> already printk a newline, so don't add one
> in the strings passed to them.

Added in different form (i had already changed that code) 

Thanks

-Andi
