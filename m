Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751115AbVKJQU6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751115AbVKJQU6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 11:20:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751117AbVKJQU6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 11:20:58 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:48016 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751115AbVKJQU5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 11:20:57 -0500
From: Tom Zanussi <zanussi@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17267.29508.365098.408615@tut.ibm.com>
Date: Thu, 10 Nov 2005 10:20:20 -0600
To: Christoph Hellwig <hch@infradead.org>
Cc: Tom Zanussi <zanussi@us.ibm.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, karim@opersys.com
Subject: Re: [PATCH 1/4] relayfs: add support for non-relay files
In-Reply-To: <20051110090227.GA6358@infradead.org>
References: <17266.28430.472991.124439@tut.ibm.com>
	<20051110090227.GA6358@infradead.org>
X-Mailer: VM 7.19 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig writes:
 > On Wed, Nov 09, 2005 at 03:50:06PM -0600, Tom Zanussi wrote:
 > > Hi,
 > > 
 > > Currently, the relayfs API only supports the creation of directories
 > > (relayfs_create_dir()) and relay files (relay_open()).  This patch
 > > adds support for non-relay files (relayfs_create_file()).
 > >     
 > > This is so relayfs applications can create 'control files' in relayfs
 > > itself rather than in /proc or via a netlink channel, as is currently
 > > done in the relay-app examples.  There were several comments that the
 > > use of netlink in the example code was non-intuitive and in fact the
 > > whole relay-app business was needlessly confusing.  Based on that
 > > feedback, the example code has been completely converted over to
 > > relayfs control files as supported by this patch, and have also been
 > > made completely self-contained.  The converted examples can be found
 > > here:
 > 
 > NACK.  please do one thing at a time in relayfs instead of adding everthing
 > and a kitchen sink.
 > 

OK, sure.  This isn't a huge patch and everything in it is related to
one logical change, the other one contains a couple of changes and
some cleanup and could easily be broken out, anyway I'll break
everything up into smaller pieces and resubmit.

Tom


