Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262129AbTHTSGZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 14:06:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262146AbTHTSGZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 14:06:25 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:778 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S262129AbTHTSGV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 14:06:21 -0400
Date: Wed, 20 Aug 2003 20:06:19 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Ulrich Drepper <drepper@redhat.com>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: NFS regression in 2.6
Message-ID: <20030820200619.A2961@pclin040.win.tue.nl>
References: <3F4268C1.9040608@redhat.com> <shszni499e9.fsf@charged.uio.no> <3F43B34D.5020503@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3F43B34D.5020503@redhat.com>; from drepper@redhat.com on Wed, Aug 20, 2003 at 10:43:41AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 20, 2003 at 10:43:41AM -0700, Ulrich Drepper wrote:

> > There are known bugs in the way we handle readdirplus. That's why it
> > only hits NFSv3. Does the following patch fix it?
> 
> As Andries suspected, no change.  The test still fails.

Try to comment out the two lines I quoted.

