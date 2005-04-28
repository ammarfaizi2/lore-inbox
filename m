Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262248AbVD1UJU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262248AbVD1UJU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 16:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262258AbVD1UJU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 16:09:20 -0400
Received: from THUNK.ORG ([69.25.196.29]:15294 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S262248AbVD1UJQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 16:09:16 -0400
Date: Thu, 28 Apr 2005 16:09:08 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Davy Durham <pubaddr2@davyandbeth.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: ext3 issue..
Message-ID: <20050428200908.GB6669@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Davy Durham <pubaddr2@davyandbeth.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <4270FA5B.5060609@davyandbeth.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4270FA5B.5060609@davyandbeth.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2005 at 09:59:39AM -0500, Davy Durham wrote:
> Crazy huh?  Well, I unmounted /home and did an fsck -f  on the partition 
> and remounted it.  Then everything looked okay.

What messages were displayed by e2fsck?  What version of the kernel
are you running?

No, I haven't heard of any such problems with ext2/3 filesystems.
This is the first time that someone was reported a specific problem
with the # of blocks used accounting.  There is the standard "file
held open so the number of blocks used is greater than blocks reported
by du", but that won't cause df to display negative numbers.

						- Ted
