Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274063AbRIXRVQ>; Mon, 24 Sep 2001 13:21:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274065AbRIXRVG>; Mon, 24 Sep 2001 13:21:06 -0400
Received: from chunnel.redhat.com ([199.183.24.220]:22517 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S274063AbRIXRUx>; Mon, 24 Sep 2001 13:20:53 -0400
Date: Mon, 24 Sep 2001 18:21:06 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Andrew Morton <akpm@zip.com.au>, lkml <linux-kernel@vger.kernel.org>,
        "ext3-users@redhat.com" <ext3-users@redhat.com>
Subject: Re: ext3-2.4-0.9.10
Message-ID: <20010924182106.J1777@redhat.com>
In-Reply-To: <3BAECC4F.EF25393@zip.com.au> <20010924101602.A25956@cpe-24-221-152-185.az.sprintbbd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010924101602.A25956@cpe-24-221-152-185.az.sprintbbd.net>; from trini@kernel.crashing.org on Mon, Sep 24, 2001 at 10:16:02AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Sep 24, 2001 at 10:16:02AM -0700, Tom Rini wrote:

> > The changes to ext3 are small, but the kernel which it patches
> > has recently changed a lot.  If you're cautious, please wait
> > a couple of days.
> 
> This doesn't  compile for me:

I just checked in a fix.  

> jbd-kernel.c:209: `BUF_PROTECTED' undeclared (first use in this function)

Simply remove that line, or undefine the CONFIG_BUFFER_DEBUG.

Cheers,
 Stephen
