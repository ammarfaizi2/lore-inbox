Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262261AbSJNXSS>; Mon, 14 Oct 2002 19:18:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262258AbSJNXSR>; Mon, 14 Oct 2002 19:18:17 -0400
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:45574 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262261AbSJNXSQ>;
	Mon, 14 Oct 2002 19:18:16 -0400
Date: Mon, 14 Oct 2002 16:24:23 -0700
From: Greg KH <greg@kroah.com>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Summit support for 2.5 - now with subarch! [0/5]
Message-ID: <20021014232423.GA8971@kroah.com>
References: <76800000.1034634448@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76800000.1034634448@flay>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2002 at 03:27:28PM -0700, Martin J. Bligh wrote:
> 
> There is an x86_summit switch variable which is needed because
> distributions want the same kernel to boot on Summit as other platforms. For
> most people, just leaving CONFIG_X86_SUMMIT turned off will give them
> exactly the same code as they had before, with no switching. Alan wanted
> it to work this way to make debugging easier, and simplify the common case.

I don't really agree with this switch variable, but if you and James are
willing to duplicate all of the code... :)

Other than that, the patches look nice.  _Very_ nice compared to the
original ones, good job.

thanks,

greg k-h
