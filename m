Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269263AbRGaLl6>; Tue, 31 Jul 2001 07:41:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269264AbRGaLls>; Tue, 31 Jul 2001 07:41:48 -0400
Received: from weta.f00f.org ([203.167.249.89]:36486 "HELO weta.f00f.org")
	by vger.kernel.org with SMTP id <S269263AbRGaLlj>;
	Tue, 31 Jul 2001 07:41:39 -0400
Date: Tue, 31 Jul 2001 23:42:20 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Hans Reiser <reiser@namesys.com>
Cc: Rik van Riel <riel@conectiva.com.br>, Christoph Hellwig <hch@caldera.de>,
        linux-kernel@vger.kernel.org
Subject: Re: ReiserFS / 2.4.6 / Data Corruption
Message-ID: <20010731234220.B7379@weta.f00f.org>
In-Reply-To: <Pine.LNX.4.33L.0107301904060.5582-100000@duckman.distro.conectiva> <3B65E177.D77ACA45@namesys.com> <20010731223203.B7257@weta.f00f.org> <3B668FA2.5E76BE1E@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B668FA2.5E76BE1E@namesys.com>
User-Agent: Mutt/1.3.18i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Tue, Jul 31, 2001 at 02:59:46PM +0400, Hans Reiser wrote:

    Sigh, I see I cannot persuade in this argument.  It seems Linus is
    right, and debugging checks don't belong in debugged code even if
    they would make it easier for persons hacking on the code to debug
    their latest hacks.

In six months time, or whenever people feel more confident about
resierfs stability (there are still many bigs to be found) then these
checks can be relaxed.

Right now, reiserfs is still relatively new --- and its much more
complex and ext2, so having additional sanity checks is a good idea.




  --cw

