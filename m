Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267423AbUJNTcU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267423AbUJNTcU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 15:32:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267381AbUJNTbg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 15:31:36 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:8337 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267417AbUJNT31
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 15:29:27 -0400
Date: Thu, 14 Oct 2004 20:29:26 +0100
From: Matthew Wilcox <matthew@wil.cx>
To: David Howells <dhowells@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [RESEND][PATCH 4/6] Add page becoming writable notification
Message-ID: <20041014192926.GT16153@parcelfarce.linux.theplanet.co.uk>
References: <24449.1097780701@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24449.1097780701@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2004 at 08:05:01PM +0100, David Howells wrote:
> +static inline int do_wp_page_mk_pte_writable(struct mm_struct *mm,
> +					     struct vm_area_struct *vma,
> +					     unsigned long address,
> +					     pte_t *page_table,
> +					     struct page *old_page,
> +					     pte_t pte)

I protest.  There are at least 3 vowels and 2 non-acronyms in this
function name.  Also, 6 arguments is clearly too few.  Can we not also
pass a struct urb, an ethtool_wolinfo and a Scsi_Cmnd?

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
