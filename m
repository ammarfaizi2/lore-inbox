Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964938AbWEUVWF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964938AbWEUVWF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 17:22:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964939AbWEUVWF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 17:22:05 -0400
Received: from smtp.bulldogdsl.com ([212.158.248.7]:44558 "EHLO
	mcr-smtp-001.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S964938AbWEUVWE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 17:22:04 -0400
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Chris Wedgwood <cw@f00f.org>
Subject: Re: Linux Kernel Source Compression
Date: Sun, 21 May 2006 22:22:14 +0100
User-Agent: KMail/1.9.1
Cc: Justin Piszcz <jpiszcz@lucidpixels.com>, linux-kernel@vger.kernel.org,
       apiszcz@lucidpixels.com
References: <Pine.LNX.4.64.0605211028100.4037@p34> <200605212003.32063.s0348365@sms.ed.ac.uk> <20060521210056.GA3500@taniwha.stupidest.org>
In-Reply-To: <20060521210056.GA3500@taniwha.stupidest.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605212222.14509.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 21 May 2006 22:00, Chris Wedgwood wrote:
> On Sun, May 21, 2006 at 08:03:32PM +0100, Alistair John Strachan wrote:
> > Somebody needs to make lzma userspace tools (like p7zip) faster, not
> > crash, and behave like a regular UNIX program. Then we need a patch
> > to GNU tar to emerge, and for it to persist for at least 4
> > years. Then maybe people will adopt this format..
>
> why?
>
> the gains aren't that great

If it was less than 5%, I'd agree with you. The fact is, it's 17% better on a 
regular kernel tarball (not exactly a contrived test), so there would be 
reason to use it. It's also faster to decompress.

http://tukaani.org/lzma/

This utility appears to address most of my original concerns (i.e., it works 
with stream LZMA and has a bzip2/gzip-esque frontend). I could see LZMA 
replacing bzip2, but not gzip, due to the compression performance issues.

-- 
Cheers,
Alistair.

Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
