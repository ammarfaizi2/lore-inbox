Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275752AbRJPJ6F>; Tue, 16 Oct 2001 05:58:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275693AbRJPJ5z>; Tue, 16 Oct 2001 05:57:55 -0400
Received: from weta.f00f.org ([203.167.249.89]:62102 "EHLO weta.f00f.org")
	by vger.kernel.org with ESMTP id <S275270AbRJPJ5l>;
	Tue, 16 Oct 2001 05:57:41 -0400
Date: Tue, 16 Oct 2001 22:58:31 +1300
From: Chris Wedgwood <cw@f00f.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: [CFT][PATCH] large /proc/mounts and friends
Message-ID: <20011016225831.A26737@weta.f00f.org>
In-Reply-To: <Pine.GSO.4.21.0110152308440.11608-100000@weyl.math.psu.edu> <Pine.LNX.4.33.0110152053080.8668-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0110152053080.8668-100000@penguin.transmeta.com>
User-Agent: Mutt/1.3.22i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2001 at 09:01:17PM -0700, Linus Torvalds wrote:

    But you're probably right that it doesn't really matter, and as we
    really have "pipe" semantics we might as well dis-allow any lseek
    except to the beginning (I know that there have been apps out
    there that avoid re-opening /proc files by lseek'ing to zero and
    re-reading - they may not be common enough to matter, though).

I always wondered why for a number of /proc entries that aren't really
files why we don't simply expose them as pipes as opposed to
zero-length files?  Surely that will confuse fewer user-land programs
as well and feeling more technically correct?



   --cw
