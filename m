Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319190AbSHNEDg>; Wed, 14 Aug 2002 00:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319196AbSHNEDf>; Wed, 14 Aug 2002 00:03:35 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:58616 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S319190AbSHNEDf>; Wed, 14 Aug 2002 00:03:35 -0400
Date: Wed, 14 Aug 2002 00:07:27 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: Linus Torvalds <torvalds@transmeta.com>, "H. Peter Anvin" <hpa@zytor.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] printk from userspace
Message-ID: <20020814000727.C15947@redhat.com>
References: <3D59CBFA.9CFC9FEE@zip.com.au> <20020813235803.A15947@redhat.com> <3D59D88B.16C23205@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D59D88B.16C23205@zip.com.au>; from akpm@zip.com.au on Tue, Aug 13, 2002 at 09:11:55PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2002 at 09:11:55PM -0700, Andrew Morton wrote:
> It requires root.

Still, unlike kernel code that can be rate limited, this call cannot.  
Besides, isn't adding yet another syscall that's equivalent to write(2) 
a reason to take this patch and burn it along with the vomit its caused?

		-ben
-- 
"You will be reincarnated as a toad; and you will be much happier."
