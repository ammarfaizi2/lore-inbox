Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261675AbUKIUKy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261675AbUKIUKy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 15:10:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261673AbUKIUKy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 15:10:54 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:17285 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261675AbUKIUKu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 15:10:50 -0500
Date: Tue, 09 Nov 2004 12:09:52 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Hugh Dickins <hugh@veritas.com>, Brent Casavant <bcasavan@sgi.com>
cc: Andi Kleen <ak@suse.de>, "Adam J. Richter" <adam@yggdrasil.com>,
       colpatch@us.ibm.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] Use MPOL_INTERLEAVE for tmpfs files
Message-ID: <463220000.1100030992@flay>
In-Reply-To: <Pine.LNX.4.44.0411091824070.5130-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0411091824070.5130-100000@localhost.localdomain>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I think the option should be "mpol=interleave" rather than just
> "interleave", who knows what baroque mpols we might want to support
> there in future?

Sounds sensible.
 
> I'm irritated to realize that we can't change the default for SysV
> shared memory or /dev/zero this way, because that mount is internal.

Boggle. shmem I can perfectly understand, and have been intending to
change for a while. But why /dev/zero ? Presumably you'd always want
that local?

Thanks,

M.

