Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263522AbSJHTyy>; Tue, 8 Oct 2002 15:54:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263457AbSJHTxg>; Tue, 8 Oct 2002 15:53:36 -0400
Received: from tapu.f00f.org ([66.60.186.129]:55016 "EHLO tapu.f00f.org")
	by vger.kernel.org with ESMTP id <S263454AbSJHTxc>;
	Tue, 8 Oct 2002 15:53:32 -0400
Date: Tue, 8 Oct 2002 12:59:13 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Matthias Schniedermeyer <ms@citd.de>
Cc: Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org, akpm@digeo.com,
       riel@conectiva.com.br
Subject: Re: [PATCH] O_STREAMING - flag for optimal streaming I/O
Message-ID: <20021008195913.GA5162@tapu.f00f.org>
References: <1034044736.29463.318.camel@phantasy> <20021008183824.GA4494@tapu.f00f.org> <1034102950.30670.1433.camel@phantasy> <20021008190513.GA4728@tapu.f00f.org> <20021008195332.GA2313@citd.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021008195332.GA2313@citd.de>
User-Agent: Mutt/1.4i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2002 at 09:53:32PM +0200, Matthias Schniedermeyer wrote:

    mkisofs?

O_DIRECT would probably win here too I think.

> I only have 3 GB of RAM, and creating and writing trashes the whole
> cache twice.

With 512MB of RAM, I stream (in the background while I'm poking about
under X with Mozilla and things) 10GB+ files around all the time and
never notice it, this is using O_DIRECT off XFS.


  --cw
