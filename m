Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265038AbTIEXWS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 19:22:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265108AbTIEXWS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 19:22:18 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:55704 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265038AbTIEXWO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 19:22:14 -0400
Date: Sat, 6 Sep 2003 00:22:12 +0100
From: Matthew Wilcox <willy@debian.org>
To: Erik Andersen <andersen@codepoet.org>, Matthew Wilcox <willy@debian.org>,
       linux-kernel@vger.kernel.org
Subject: Re: kernel header separation
Message-ID: <20030905232212.GP18654@parcelfarce.linux.theplanet.co.uk>
References: <20030902191614.GR13467@parcelfarce.linux.theplanet.co.uk> <20030903014908.GB1601@codepoet.org> <20030905144154.GL18654@parcelfarce.linux.theplanet.co.uk> <20030905211604.GB16993@codepoet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030905211604.GB16993@codepoet.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 05, 2003 at 03:16:04PM -0600, Erik Andersen wrote:
> On Fri Sep 05, 2003 at 03:41:54PM +0100, Matthew Wilcox wrote:
> > i think all these _t types are ugly ;-(
> 
> They may be ugly, but they are standardized and have very 
> precise meanings defined by ISO C99, which is a very good
> thing for code interoperability...

__u8 has a very precise meaning defined by Linux.  If you're including
a Linux header. that's what you need to worry about.

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
