Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264156AbTFUW5k (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 18:57:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264146AbTFUW5k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 18:57:40 -0400
Received: from dixville.unh.edu ([132.177.137.38]:13001 "EHLO dixville.unh.edu")
	by vger.kernel.org with ESMTP id S264124AbTFUW5g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 18:57:36 -0400
Date: Sat, 21 Jun 2003 19:11:36 -0400
From: Samuel Thibault <Samuel.Thibault@ens-lyon.fr>
To: "J.C. Wren" <jcwren@jcwren.com>
Cc: linux-kernel@vger.kernel.org, rdr@cs.unh.edu
Subject: Re: Kernel facilities for tracking file accesses
Message-ID: <20030621231136.GE650@bouh.unh.edu>
Reply-To: Samuel Thibault <samuel.thibault@fnac.net>
Mail-Followup-To: "J.C. Wren" <jcwren@jcwren.com>,
	linux-kernel@vger.kernel.org, rdr@cs.unh.edu
References: <20030621204615.GA32341@peter.cfs> <3EF4DCEF.7080708@yahoo.ca> <200306211845.41702.jcwren@jcwren.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200306211845.41702.jcwren@jcwren.com>
User-Agent: Mutt/1.4i-nntp
X-MailScanner-Information: http://pubpages.unh.edu/notes/mailfiltering.html
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-8.4, required 5,
	BAYES_10, EMAIL_ATTRIBUTION, IN_REP_TO, REFERENCES,
	REPLY_WITH_QUOTES, USER_AGENT_MUTT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On sat 21 jun 2003 18:45:41 GMT, J.C. Wren wrote:
> 	Does any facility exist in the 2.4 and up kernels for logging *every* open, 
> read, write, seek, close, etc call?

I'm currently working on Robert D. Russell's "Fast Kernel Tracing", see
his homepage http://www.cs.unh.edu/~rdr/ for the paper & distribution.
This is for kernel 2.4.0-test9, though.

The most recent version I'm working on is for 2.4.21, should support
on-the-fly log flushing and work on smp (not much tested though, it
began to work yesterday :) ). It might be ported to 2.5 without too
much work.

Hoping this might meet your needs,
Samuel Thibault
