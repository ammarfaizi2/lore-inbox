Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280805AbRLGNY5>; Fri, 7 Dec 2001 08:24:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280814AbRLGNYs>; Fri, 7 Dec 2001 08:24:48 -0500
Received: from uisge.3dlabs.com ([193.133.230.45]:40402 "EHLO uisge.3dlabs.com")
	by vger.kernel.org with ESMTP id <S280805AbRLGNY3>;
	Fri, 7 Dec 2001 08:24:29 -0500
Date: Fri, 7 Dec 2001 13:23:17 +0000
From: Paul Sargent <Paul.Sargent@3dlabs.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2GB process crashing on 2.4.14
Message-ID: <20011207132317.E31161@3dlabs.com>
In-Reply-To: <20011207125821.D31161@3dlabs.com> <E16CKrx-0005nL-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16CKrx-0005nL-00@the-village.bc.nu>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07, 2001 at 01:16:49PM +0000, Alan Cox wrote:
> Most probably the process is running out of address space to allocate from.
> There is 3Gb of available space. 

That would be from 0x00000000 to 0xC0000000, Right?

> Of that some is your stack, some your
> binary, some your libraries.  Getting above 3Gb/process on x86 is very hairy
> with a bad performance hit

So if I was hitting this limit then I should see no / very few gaps, in the
/proc/<pid>/maps. Is that true?

Paul

-- 
Paul Sargent
Tel: +44 (1784) 476669
Fax: +44 (1784) 470699
mailto: Paul.Sargent@3Dlabs.com
