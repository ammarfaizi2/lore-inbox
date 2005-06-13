Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261574AbVFMNzD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261574AbVFMNzD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 09:55:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261575AbVFMNzD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 09:55:03 -0400
Received: from wproxy.gmail.com ([64.233.184.195]:62618 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261574AbVFMNy6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 09:54:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nDi2HoNPZO4hN11y7U5kqmOl+9qgLRV6wEKBH4vV+lHXlPW2eQ2ZN+u/QRJtC4aoHAttsA0oCUZUEh+5KJ5nopJVKgTSNwEteOTdxjPZodwJLkHYI7u8IrIXpRx9ToLAPhKyA3eam6wVpf0MDdz6PUcpuc+uo2eCN5uQv02GwUk=
Message-ID: <f1929877050613065461ad3253@mail.gmail.com>
Date: Mon, 13 Jun 2005 17:54:58 +0400
From: Alexey Zaytsev <alexey.zaytsev@gmail.com>
Reply-To: Alexey Zaytsev <alexey.zaytsev@gmail.com>
To: Bernd Petrovitsch <bernd@firmix.at>
Subject: Re: A Great Idea (tm) about reimplementing NLS.
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1118664352.898.16.camel@tara.firmix.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <f192987705061303383f77c10c@mail.gmail.com>
	 <1118664352.898.16.camel@tara.firmix.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/06/05, Bernd Petrovitsch <bernd@firmix.at> wrote:
> On Mon, 2005-06-13 at 14:38 +0400, Alexey Zaytsev wrote:
> [ Filenames with another encoding ]
> > Some would suggest not to use non-ascii file names at all, some would
> > say that I should temporary change my locale, some could even offer me
> > a perl script they wrote when faced the same problem. All these
> > solutions are inconvenient and conflict with fundamental VFS concepts.
>                                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> In what way?
> Basically you just rename the files. How can this conflict with
> "fundamental VFS concepts" (and with which).

I can't rename files on Pupkin's drive because he won't like it. ;)
In the case with a flash drive I can copy all the files to my computer
and rename them, but I can't do it with a bigger media like hard disk.

The main idea of VFS is that you can access your files in the same way
on any supported file system. But actually you can't simple access
different-encoded non-ascii files on a filesystem that has no NLS,
like ext or reiser.
 
>        Bernd
