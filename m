Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262977AbVAFTOW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262977AbVAFTOW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 14:14:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262974AbVAFTOV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 14:14:21 -0500
Received: from [213.146.154.40] ([213.146.154.40]:12716 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262972AbVAFTOH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 14:14:07 -0500
Date: Thu, 6 Jan 2005 19:13:55 +0000
From: Christoph Hellwig <hch@infradead.org>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, jtk@us.ibm.com,
       wtaber@us.ibm.com, pbadari@us.ibm.com, markv@us.ibm.com,
       viro@parcelfarce.linux.theplanet.co.uk, greghk@us.ibm.com
Subject: Re: [PATCH] fs: Restore files_lock and set_fs_root exports
Message-ID: <20050106191355.GA23345@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Paul E. McKenney" <paulmck@us.ibm.com>, akpm@osdl.org,
	linux-kernel@vger.kernel.org, jtk@us.ibm.com, wtaber@us.ibm.com,
	pbadari@us.ibm.com, markv@us.ibm.com,
	viro@parcelfarce.linux.theplanet.co.uk, greghk@us.ibm.com
References: <20050106190538.GB1618@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050106190538.GB1618@us.ibm.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2005 at 11:05:38AM -0800, Paul E. McKenney wrote:
> Hello, Andrew,
> 
> Some export-removal work causes breakage for an out-of-tree filesystem.
> Could you please apply the attached patch to restore the exports for
> files_lock and set_fs_root?

What out of tree filesystem, and what the heck is it doing?

Without proper explanation it's vetoed.

btw, any reason you put half the world in the Cc list?  Al and Andrew I
see, but do the other people on the Cc list have to do with it?  And you
forgot the person that killed the export.
