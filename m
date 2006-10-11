Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751247AbWJKMvR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247AbWJKMvR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 08:51:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbWJKMvR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 08:51:17 -0400
Received: from thunk.org ([69.25.196.29]:6787 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1751247AbWJKMvP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 08:51:15 -0400
Date: Wed, 11 Oct 2006 08:51:08 -0400
From: Theodore Tso <tytso@mit.edu>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc1-mm1
Message-ID: <20061011125108.GH27591@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Badari Pulavarty <pbadari@us.ibm.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20061010000928.9d2d519a.akpm@osdl.org> <452C616D.7040701@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <452C616D.7040701@us.ibm.com>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2006 at 08:13:49PM -0700, Badari Pulavarty wrote:
> Hi Ted,
> 
> e2fsprogs-1.39-tyt1-rollup.patch doesn't compile. (seems to be missing 
> percent.c). Can
> you role up new version ? I had to apply individual patches to get it 
> working ..

OK, fixed.  I've also created a slightly new structure in:

ftp://ftp.kernel.org/pub/linux/kernel/people/tytso/e2fsprogs-interim

Each new version will be its own directory, i.e., e2fsprogs-1.39-tyt1,
with a symlink LATEST pointing at the most recent directory.

Within each directory, there will be a tarball of the complete
sources, as requested by akpm, as well a broken-out tar.gz file and a
single file that has all of the patches rolled up.  I've regenerated
the rollup patches this time with feeling (and the -N diff option :-),
so once the new structure gets mirrored out from master.kernel.org to
ftp.kernel.org, you should be able to get the fixed rollup patch, as
well as a pre-patched tarball.

Regards,

						- Ted
