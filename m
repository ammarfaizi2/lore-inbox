Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265665AbUATSaq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 13:30:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265667AbUATSaq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 13:30:46 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:14217 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP id S265665AbUATSao
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 13:30:44 -0500
Date: Tue, 20 Jan 2004 10:30:20 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.1-mm5
Message-ID: <20040120183020.GD23765@srv-lnx2600.matchmail.com>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20040120000535.7fb8e683.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040120000535.7fb8e683.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 20, 2004 at 12:05:35AM -0800, Andrew Morton wrote:
> -ext2_new_inode-cleanup.patch
> -ext2-s_next_generation-fix.patch
> -ext3-s_next_generation-fix.patch
> -ext3-journal-mode-fix.patch

What do these patches do?

> -nfsd-01-stale-filehandles-fixes.patch
>  Merged

Yes!

I tested this against 2.6.1-bk2 on my knfsd server since friday, and it has
fixed my problems with stale nfs handles.  Without the patch, it wouldn't
last a whole day before the errors started cropping up.
