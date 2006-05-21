Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964948AbWEUV5B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964948AbWEUV5B (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 17:57:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964944AbWEUV5B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 17:57:01 -0400
Received: from smtp.bulldogdsl.com ([212.158.248.8]:64009 "EHLO
	mcr-smtp-002.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S964948AbWEUV5A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 17:57:00 -0400
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Sam Vilain <sam@vilain.net>
Subject: Re: Linux Kernel Source Compression
Date: Sun, 21 May 2006 22:57:10 +0100
User-Agent: KMail/1.9.1
Cc: Chris Wedgwood <cw@f00f.org>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.64.0605211028100.4037@p34> <20060521210056.GA3500@taniwha.stupidest.org> <4470DEC4.6050308@vilain.net>
In-Reply-To: <4470DEC4.6050308@vilain.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605212257.10934.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 21 May 2006 22:42, Sam Vilain wrote:
> Chris Wedgwood wrote:
> >On Sun, May 21, 2006 at 08:03:32PM +0100, Alistair John Strachan wrote:
> >>Somebody needs to make lzma userspace tools (like p7zip) faster, not
> >>crash, and behave like a regular UNIX program. Then we need a patch
> >>to GNU tar to emerge, and for it to persist for at least 4
> >>years. Then maybe people will adopt this format..
> >
> >why?
> >
> >the gains aren't that great
>
> Exactly, and while I know my network connection isn't exactly
> representative of the general population of people building the kernel,
> it's currently faster for me to download and unpack a .gz than to wait
> the extra time for bzip2 to decompress. I've always found it quicker
> dealing with .gz's for incremental patches. I thought the speed issue is
> more of a speed / compression ratio trade-off, ie a caveat of
> compression in general.

Actually, you're making false assumptions about LZMA. It is in fact quicker to 
decompress than bzip2, which largely addresses this issue. Compression speeds 
are the problem, but the end user won't do a lot of that.

-- 
Cheers,
Alistair.

Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
