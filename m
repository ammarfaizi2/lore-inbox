Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262972AbVAFTRZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262972AbVAFTRZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 14:17:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262967AbVAFTRZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 14:17:25 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:696 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262972AbVAFTOq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 14:14:46 -0500
Date: Thu, 6 Jan 2005 19:14:41 +0000
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, jtk@us.ibm.com,
       wtaber@us.ibm.com, pbadari@us.ibm.com, markv@us.ibm.com,
       greghk@us.ibm.com
Subject: Re: [PATCH] fs: Restore files_lock and set_fs_root exports
Message-ID: <20050106191441.GM26051@parcelfarce.linux.theplanet.co.uk>
References: <20050106190538.GB1618@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050106190538.GB1618@us.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2005 at 11:05:38AM -0800, Paul E. McKenney wrote:
> Hello, Andrew,
> 
> Some export-removal work causes breakage for an out-of-tree filesystem.
> Could you please apply the attached patch to restore the exports for
> files_lock and set_fs_root?

What, in name of everything unholy, is *filesystem* doing with set_fs_root()?
