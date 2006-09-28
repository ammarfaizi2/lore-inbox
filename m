Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161125AbWI1NcF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161125AbWI1NcF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 09:32:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751895AbWI1NcE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 09:32:04 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:18315 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751892AbWI1Nb7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 09:31:59 -0400
Date: Thu, 28 Sep 2006 14:31:56 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: J?rn Engel <joern@wohnheim.fh-wedel.de>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org,
       holzheu@de.ibm.com
Subject: Re: [S390] hypfs sparse warnings.
Message-ID: <20060928133156.GG29920@ftp.linux.org.uk>
References: <20060928130737.GB1120@skybase> <20060928132540.GA18933@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060928132540.GA18933@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2006 at 03:25:40PM +0200, J?rn Engel wrote:
> On Thu, 28 September 2006 15:07:37 +0200, Martin Schwidefsky wrote:
> > 
> > sparse complains, if we use bitwise operations on enums. Cast enum to
> > long in order to fix that problem!
> 
> At this point I start to wonder which part should be changed.  Is it
> better to
> a) cast some more, as you started to do,
> b) change enums to #defines or
> c) change '|' to '+'?
> 
> At any rate, you have the same problem in 5 seperate places by my
> count and only changed 1 of them.  Nak - in case anyone cares.

Split enums sanely.
