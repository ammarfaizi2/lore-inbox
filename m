Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261451AbSJQPDK>; Thu, 17 Oct 2002 11:03:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261403AbSJQPDK>; Thu, 17 Oct 2002 11:03:10 -0400
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:51213 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261451AbSJQPDJ>;
	Thu, 17 Oct 2002 11:03:09 -0400
Date: Thu, 17 Oct 2002 08:08:50 -0700
From: Greg KH <greg@kroah.com>
To: Christoph Hellwig <hch@infradead.org>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove LSM file_llseek hook
Message-ID: <20021017150849.GB31056@kroah.com>
References: <20021017155207.A28782@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021017155207.A28782@infradead.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2002 at 03:52:07PM +0100, Christoph Hellwig wrote:
> In the initial discussion LSM folks agreed on this, the
> rationale is that lsseek itself makes no sense to
> project as mmap() and pread/pwrite() allow access to any
> area of the file anyway.

Thanks for the patch.  As I'm changing all the hooks right now, I'll add
this to my patches that I'm going to send to Linus later today.

thanks,

greg k-h
