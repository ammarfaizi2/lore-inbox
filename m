Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264166AbTJOTeN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 15:34:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264198AbTJOTeM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 15:34:12 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:21124 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264166AbTJOTeG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 15:34:06 -0400
Date: Wed, 15 Oct 2003 20:34:05 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>, Christoph Rohland <cr@sap.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tmpfs 2/7 LTP S_ISGID dir
Message-ID: <20031015193404.GT7665@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.44.0310151915590.5350-100000@localhost.localdomain> <Pine.LNX.4.44.0310151918560.5350-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310151918560.5350-100000@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 15, 2003 at 07:19:46PM +0100, Hugh Dickins wrote:
> LTP tests the filesystem on /tmp: many failures when tmpfs because
> it missed the way giddy directories hand down their gid.  Also fix
> ramfs and hugetlbfs.

*the* way?  I can think of at least two...
