Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263106AbTIEOoF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 10:44:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263076AbTIEOoF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 10:44:05 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:15061 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263106AbTIEOmB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 10:42:01 -0400
Date: Fri, 5 Sep 2003 15:41:54 +0100
From: Matthew Wilcox <willy@debian.org>
To: Erik Andersen <andersen@codepoet.org>, Matthew Wilcox <willy@debian.org>,
       linux-kernel@vger.kernel.org
Subject: Re: kernel header separation
Message-ID: <20030905144154.GL18654@parcelfarce.linux.theplanet.co.uk>
References: <20030902191614.GR13467@parcelfarce.linux.theplanet.co.uk> <20030903014908.GB1601@codepoet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030903014908.GB1601@codepoet.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 02, 2003 at 07:49:09PM -0600, Erik Andersen wrote:
> Header files intended for use by users should probably drop
> linux/types.h just include <stdint.h>,,,  Then convert the 
> types over to ISO C99 types.

stdint.h is a userspace header.  I suppose we could clone it for the
kernel, but I don't see any need to.

> s/__u8/uint8_t/g
> s/__u16/uint16_t/g
> s/__u32/uint32_t/g
> s/__u64/uint64_t/g

i think all these _t types are ugly ;-(

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
