Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316951AbSEWQfN>; Thu, 23 May 2002 12:35:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316952AbSEWQfN>; Thu, 23 May 2002 12:35:13 -0400
Received: from imladris.infradead.org ([194.205.184.45]:24077 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S316951AbSEWQfL>; Thu, 23 May 2002 12:35:11 -0400
Date: Thu, 23 May 2002 17:34:25 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Sebastian Droege <sebastian.droege@gmx.de>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [2.5.17-cset1.656] patch to compile nfs (and maybe others)
Message-ID: <20020523173425.A1713@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Sebastian Droege <sebastian.droege@gmx.de>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020523182601.19620dbd.sebastian.droege@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2002 at 06:26:01PM +0200, Sebastian Droege wrote:
> Hi,
> this trivial patch adds 3 missing #includes
> without them at least nfs won't compile

Please don't add additional includes to namei.h - it's purpose is to
ubbork the headers instead of makeing them more complicated.

I have another bunch of header fixes (including the proper fixe for
this failure) queued up for Linux after the buffer_head.h stuff goes in.

