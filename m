Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129455AbRADX3k>; Thu, 4 Jan 2001 18:29:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129518AbRADX3b>; Thu, 4 Jan 2001 18:29:31 -0500
Received: from zeus.kernel.org ([209.10.41.242]:8458 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129455AbRADX30>;
	Thu, 4 Jan 2001 18:29:26 -0500
Date: Thu, 4 Jan 2001 23:25:41 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Alexander Viro <viro@math.psu.edu>
Cc: "Stephen C. Tweedie" <sct@redhat.com>,
        Andreas Dilger <adilger@enel.ucalgary.ca>,
        Andreas Dilger <adilger@turbolinux.com>, linux-kernel@vger.kernel.org,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Ext2 development mailing list 
	<ext2-devel@lists.sourceforge.net>
Subject: Re: [Ext2-devel] Re: [RFC] ext2_new_block() behaviour
Message-ID: <20010104232541.J1290@redhat.com>
In-Reply-To: <20010104220433.T1290@redhat.com> <Pine.GSO.4.21.0101041721531.20875-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.GSO.4.21.0101041721531.20875-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Thu, Jan 04, 2001 at 05:31:12PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jan 04, 2001 at 05:31:12PM -0500, Alexander Viro wrote:
> 
> BTW, what inumber do you want for whiteouts? IIRC, we decided to use
> the same entry type as UFS does (14), but I don't remember what was
> the decision on inumber. UFS uses 1 for them, is it OK with you?

0 is used for padding, so 1 makes sense, yes.

--Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
