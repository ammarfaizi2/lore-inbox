Return-Path: <linux-kernel-owner+w=401wt.eu-S1751477AbWLLPyc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751477AbWLLPyc (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 10:54:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751478AbWLLPyc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 10:54:32 -0500
Received: from smtp.osdl.org ([65.172.181.25]:38854 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751477AbWLLPyb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 10:54:31 -0500
Date: Tue, 12 Dec 2006 07:54:21 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: art@usfltd.com
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-git problem - dvd+rw-usb - :-( not an MMC unit!
In-Reply-To: <20061211151204.gz85ndgoe2o0ccws@69.222.0.225>
Message-ID: <Pine.LNX.4.64.0612120752280.6452@woody.osdl.org>
References: <20061211151204.gz85ndgoe2o0ccws@69.222.0.225>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 11 Dec 2006, art@usfltd.com wrote:
> 
> 2.6.19-git problem - dvd+rw-usb - :-( not an MMC unit!

Ok, this should be fixed in the current -git tree now (which I pushed out 
already, but due to mirroring delays it might not be visible for a while). 
If you see the commit "[PATCH] fix SG_IO bio leak" by FUJITA Tomonori, you 
should have the fixed tree.

(Commit 77d172ce2719b5ad2dc0637452c8871d9cba344c to be precise).

Thanks for noticing,

		Linus
