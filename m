Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262056AbUBXDBC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 22:01:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262143AbUBXDBC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 22:01:02 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:12751 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262056AbUBXDBA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 22:01:00 -0500
Date: Tue, 24 Feb 2004 03:00:57 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Ian Wienand <ianw@gelato.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] devpts_fs.h fails with "error: parameter name omitted"
Message-ID: <20040224030056.GN31035@parcelfarce.linux.theplanet.co.uk>
References: <20040224021651.GF1200@cse.unsw.EDU.AU> <20040224022424.GL31035@parcelfarce.linux.theplanet.co.uk> <20040224024942.GG1200@cse.unsw.EDU.AU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040224024942.GG1200@cse.unsw.EDU.AU>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 24, 2004 at 01:49:42PM +1100, Ian Wienand wrote:
> On Tue, Feb 24, 2004 at 02:24:24AM +0000, viro@parcelfarce.linux.theplanet.co.uk wrote:
> > That part makes sense.  Previous one doesn't.
> 
> Is that by convention or is leaving out the parameter name in the
> prototype standardised somewhere?  

It's valid C and it's pretty common style.  Both that and leaving the
names in prototype can be found in the kernel and CodingStyle is OK
with either variant.  Which makes the change gratitious.
