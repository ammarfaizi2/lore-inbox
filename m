Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315471AbSEHAE0>; Tue, 7 May 2002 20:04:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315472AbSEHAEZ>; Tue, 7 May 2002 20:04:25 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:13026 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S315471AbSEHAEZ>; Tue, 7 May 2002 20:04:25 -0400
Date: Tue, 7 May 2002 16:58:50 -0700
From: Greg KH <gregkh@us.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IBM hotplug PCI, many missing __init's
Message-ID: <20020507235849.GA15523@us.ibm.com>
In-Reply-To: <20020507114714.GA620@pazke.ipt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Operating-System: Linux 2.5.14 (i686)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 07, 2002 at 03:47:14PM +0400, Andrey Panin wrote:
> Hi,
> 
> this patch adds many missing __init modifiers to IBM hotplug PCI driver.
> Patch against 2.5.14. Compiles, but untested. 
> Please consider applying.

Thanks, I'll take the portions that add __init, but not the ones that
add "inline" as it's not necessary.  Hm, in looking at the code some
more, I'll add __init to a few more places :)

thanks again for the patch.

greg k-h
