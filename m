Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932181AbWDFWMe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932181AbWDFWMe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 18:12:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932182AbWDFWMe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 18:12:34 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:57052 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932181AbWDFWMd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 18:12:33 -0400
Date: Fri, 7 Apr 2006 08:11:48 +1000
From: Nathan Scott <nathans@sgi.com>
To: Jeff Dike <jdike@addtoit.com>
Cc: akpm@osdl.org, linux-xfs@oss.sgi.com,
       Daniel Phillips <phillips@google.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [PATCH 1/2] Add GFP_NOWAIT
Message-ID: <20060407081148.J1110920@wobbly.melbourne.sgi.com>
References: <200604061655.k36GtMvc005146@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200604061655.k36GtMvc005146@ccure.user-mode-linux.org>; from jdike@addtoit.com on Thu, Apr 06, 2006 at 12:55:22PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 06, 2006 at 12:55:22PM -0400, Jeff Dike wrote:
> Introduce GFP_NOWAIT, as an alias for GFP_ATOMIC & ~__GFP_HIGH.
> 
> This also changes XFS, which is the only in-tree user of this idiom that I 
> could find.  The XFS piece is compile-tested only.

Looks fine, thanks Jeff.

> Signed-off-by: Jeff Dike <jdike@addtoit.com>
Acked-by: Nathan Scott <nathans@sgi.com>

cheers.

-- 
Nathan
