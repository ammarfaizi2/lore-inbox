Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262048AbUCDRtP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 12:49:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262049AbUCDRtP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 12:49:15 -0500
Received: from abraham.CS.Berkeley.EDU ([128.32.37.170]:6919 "EHLO
	abraham.cs.berkeley.edu") by vger.kernel.org with ESMTP
	id S262048AbUCDRtM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 12:49:12 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@taverner.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: dm-crypt, new IV and standards
Date: Thu, 4 Mar 2004 17:44:25 +0000 (UTC)
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <c27ptp$dhp$1@abraham.cs.berkeley.edu>
References: <20040220172237.GA9918@certainkey.com> <20040303150647.GC1586@certainkey.com> <Pine.LNX.4.58.0403031735210.26196@twinlark.arctic.org> <20040304132430.GA8213@certainkey.com>
Reply-To: daw-usenet@taverner.cs.berkeley.edu (David Wagner)
NNTP-Posting-Host: taverner.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 1078422265 13881 128.32.153.228 (4 Mar 2004 17:44:25 GMT)
X-Complaints-To: usenet@abraham.cs.berkeley.edu
NNTP-Posting-Date: Thu, 4 Mar 2004 17:44:25 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: daw@taverner.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean-Luc Cooke  wrote:
>Like you said, CBC is not trivial to temper with - though it is do able.  CTR
>is trivial on the other hand.  Which is why NIST and every cryptographer will
>recommend using a MAC with CTR.  (Why still have CTR?  Unlike CBC, you can
>compute the N+1-th block without needing to know the output from the N-th
>block, so there is the possibility for very high parallelizum).

I'm worried about the potential for confusion, so let me clarify: Good
cryptographers will recommend using a MAC, whether you use CTR, CBC,
or CFB.  The need for a MAC is not specific to CTR; CBC is not exempt.
