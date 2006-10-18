Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030186AbWJRKcJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030186AbWJRKcJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 06:32:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751463AbWJRKcJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 06:32:09 -0400
Received: from ftp.linux-mips.org ([194.74.144.162]:38561 "EHLO
	ftp.linux-mips.org") by vger.kernel.org with ESMTP id S1751461AbWJRKcG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 06:32:06 -0400
Date: Wed, 18 Oct 2006 11:32:21 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Make <linux/personality.h> userspace proof
Message-ID: <20061018103221.GA28696@linux-mips.org>
References: <20061017155526.GA9888@linux-mips.org> <20061018102433.GB1767@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061018102433.GB1767@infradead.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2006 at 11:24:33AM +0100, Christoph Hellwig wrote:

> On Tue, Oct 17, 2006 at 04:55:26PM +0100, Ralf Baechle wrote:
> > <linux/personality.h> contains the constants for personality(2) but also
> > some defintions that are useless or even harmful in userspace such as
> > the personality() macro.
> 
> NACK.  glibc has a <sys/personality.h> for that.  It's been there since
> at least glibc 2.3.

And I ran over this on a glibc 2.2 system ...

  Ralf
