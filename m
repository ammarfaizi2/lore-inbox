Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262161AbSIZDXv>; Wed, 25 Sep 2002 23:23:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262160AbSIZDXv>; Wed, 25 Sep 2002 23:23:51 -0400
Received: from thunk.org ([140.239.227.29]:39327 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id <S262161AbSIZDXt>;
	Wed, 25 Sep 2002 23:23:49 -0400
Date: Wed, 25 Sep 2002 23:28:30 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Aaron Lehmann <aaronl@vitelus.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] Add ext3 indexed directory (htree) support
Message-ID: <20020926032830.GB4072@think.thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Aaron Lehmann <aaronl@vitelus.com>, linux-kernel@vger.kernel.org
References: <E17uINs-0003bG-00@think.thunk.org> <20020926005020.GA4587@vitelus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020926005020.GA4587@vitelus.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2002 at 05:50:20PM -0700, Aaron Lehmann wrote:
> On Wed, Sep 25, 2002 at 04:03:44PM -0400, tytso@mit.edu wrote:
> > In order to use the new directory indexing feature, please update your
> > e2fsprogs to 1.29.  Existing filesystem can be updated to use directory
> > indexing using the command "tune2fs -O dir_index /dev/hdXXX".
> 
> Do new filesystems created with e2fsprogs 1.29 use this feature by
> default?

Yes, they do.  The "tune2fs -O dir_index" command is only needed for
filesystems created before 1.29.

						- Ted
