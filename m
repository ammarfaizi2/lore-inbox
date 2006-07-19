Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932525AbWGSICP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932525AbWGSICP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 04:02:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932526AbWGSICP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 04:02:15 -0400
Received: from frankvm.xs4all.nl ([80.126.170.174]:60559 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S932525AbWGSICO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 04:02:14 -0400
Date: Wed, 19 Jul 2006 10:02:13 +0200
From: Frank van Maarseveen <frankvm@frankvm.com>
To: Bill Ryder <bryder@wetafx.co.nz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.18-rc1]  Make group sorting optional in the 2.6.x kernels
Message-ID: <20060719080213.GA22925@janus>
References: <44B32888.6050406@wetafx.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44B32888.6050406@wetafx.co.nz>
User-Agent: Mutt/1.4.1i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2006 at 04:26:48PM +1200, Bill Ryder wrote:
> Hello all,
> 
> Setting the kernel config option of UNSORTED_SUPPLEMENTAL_GROUPLIST
> will allow the use of setgroups(2) to reorder a supplemental
> group list to work around the NFS AUTH_UNIX 16 group limit. 

FYI,

This problem has been worked around for several years now using
these 2.4.x and 2.6.x patches:

	http://www.frankvm.com/nfs-ngroups/


-- 
Frank
