Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262661AbTIEVQJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 17:16:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261276AbTIEVQI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 17:16:08 -0400
Received: from codepoet.org ([166.70.99.138]:62166 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id S262661AbTIEVQE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 17:16:04 -0400
Date: Fri, 5 Sep 2003 15:16:04 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Matthew Wilcox <willy@debian.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel header separation
Message-ID: <20030905211604.GB16993@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Matthew Wilcox <willy@debian.org>, linux-kernel@vger.kernel.org
References: <20030902191614.GR13467@parcelfarce.linux.theplanet.co.uk> <20030903014908.GB1601@codepoet.org> <20030905144154.GL18654@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030905144154.GL18654@parcelfarce.linux.theplanet.co.uk>
X-Operating-System: Linux 2.4.19-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Sep 05, 2003 at 03:41:54PM +0100, Matthew Wilcox wrote:
> On Tue, Sep 02, 2003 at 07:49:09PM -0600, Erik Andersen wrote:
> > Header files intended for use by users should probably drop
> > linux/types.h just include <stdint.h>,,,  Then convert the 
> > types over to ISO C99 types.
> 
> stdint.h is a userspace header.  I suppose we could clone it for the
> kernel, but I don't see any need to.
> 
> > s/__u8/uint8_t/g
> > s/__u16/uint16_t/g
> > s/__u32/uint32_t/g
> > s/__u64/uint64_t/g
> 
> i think all these _t types are ugly ;-(

They may be ugly, but they are standardized and have very 
precise meanings defined by ISO C99, which is a very good
thing for code interoperability...

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
