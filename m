Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262144AbUBXEbZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 23:31:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262159AbUBXEbZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 23:31:25 -0500
Received: from hera.kernel.org ([63.209.29.2]:52964 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S262144AbUBXEbY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 23:31:24 -0500
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: [PATCH] devpts_fs.h fails with "error: parameter name omitted"
Date: Tue, 24 Feb 2004 04:31:21 +0000 (UTC)
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <c1ek2p$jq5$1@terminus.zytor.com>
References: <20040224021651.GF1200@cse.unsw.EDU.AU> <20040224022424.GL31035@parcelfarce.linux.theplanet.co.uk> <20040224024942.GG1200@cse.unsw.EDU.AU>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1077597081 20294 63.209.29.3 (24 Feb 2004 04:31:21 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Tue, 24 Feb 2004 04:31:21 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20040224024942.GG1200@cse.unsw.EDU.AU>
By author:    Ian Wienand <ianw@gelato.unsw.edu.au>
In newsgroup: linux.dev.kernel
> 
> On Tue, Feb 24, 2004 at 02:24:24AM +0000, viro@parcelfarce.linux.theplanet.co.uk wrote:
> > That part makes sense.  Previous one doesn't.
> 
> Is that by convention or is leaving out the parameter name in the
> prototype standardised somewhere?  
> 

It's commonly done to make code less macro-sensitive.

Personally I wish that standard C allowed it for definitions as well, rather than
having to type (void)foo; to keep it from complaining about unused parameters.

	-hpa
