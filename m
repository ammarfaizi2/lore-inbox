Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266582AbUBMBq3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 20:46:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266619AbUBMBq3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 20:46:29 -0500
Received: from [212.28.208.94] ([212.28.208.94]:14598 "HELO dewire.com")
	by vger.kernel.org with SMTP id S266582AbUBMBq2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 20:46:28 -0500
From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
To: Jamie Lokier <jamie@shareable.org>
Subject: Re: JFS default behavior (was: UTF-8 in file systems? xfs/extfs/etc.)
Date: Fri, 13 Feb 2004 02:46:25 +0100
User-Agent: KMail/1.6.1
Cc: Linux kernel <linux-kernel@vger.kernel.org>
References: <20040209115852.GB877@schottelius.org> <200402130216.53434.robin.rosenberg.lists@dewire.com> <20040213012326.GA25499@mail.shareable.org>
In-Reply-To: <20040213012326.GA25499@mail.shareable.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200402130246.25005.robin.rosenberg.lists@dewire.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 13 February 2004 02.23, Jamie Lokier wrote:
> Robin Rosenberg wrote:
> > Is there a place to store character set information in these file systems?
> 
> Please don't confuse character set with character encoding.  The
> problem we are talking about here is about character encoding.
> Once upon a time the two were muddled; that's why MIME and HTTP use
> "charset" to mean character encoding.
I shall try not to mix them in the future. The reason for the name in MIME is
probably because a (mime)charset does specify a character set (+encoding),
while the mime-encoding only specifies raw bytes.

> And the answer is: yes, you can store it wherever you want :)
I was thinking of the file system meta data so mount or the kernel or the fs could 
handle it.

> > Some apps simply don't think non-ascii is relevant. Xmms is one, although
> > is doesn't crash at least. My guess was that it was a font problem since it
> > looks like XMMS uses some special fonts.
> 
> It's not a font problem.  XMMS simply displays each byte as a separate
> character because that's what it assumes it should do.  No font will fix that.
I assumed a font problem because my machine is using ISO-8859-1 and 
XMMS doesn't display tose non-ascii characters I use; of course it could be both.

-- robin
