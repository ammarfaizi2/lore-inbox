Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261728AbUKIWOz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261728AbUKIWOz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 17:14:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261729AbUKIWOz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 17:14:55 -0500
Received: from gate.crashing.org ([63.228.1.57]:37523 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261728AbUKIWOy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 17:14:54 -0500
Subject: Re: [PATCH] ppc64: Bump MAX_HWIFS in IDE code
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Chris Wedgwood <cw@f00f.org>
Cc: Andrew Morton <akpm@osdl.org>, Anton Blanchard <anton@samba.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20041109211201.GA8998@taniwha.stupidest.org>
References: <20041109203028.GA26806@krispykreme.ozlabs.ibm.com>
	 <20041109125507.4bc49b3c.akpm@osdl.org>
	 <20041109211201.GA8998@taniwha.stupidest.org>
Content-Type: text/plain
Date: Wed, 10 Nov 2004 09:12:45 +1100
Message-Id: <1100038365.3946.236.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-11-09 at 13:12 -0800, Chris Wedgwood wrote:
> On Tue, Nov 09, 2004 at 12:55:07PM -0800, Andrew Morton wrote:
> 
> > hrmph.  That costs 50kbytes, excluding ide-tape.  It's worth a
> > config variable, I think.
> 
> this come up from time to time, and i wonder why it can't be dynamic?

Good question :) I suppose Bart has that on his todolist, but it will
require some work on the IDE layer, which only few people can do without
breaking it all :)

Ben.


