Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129853AbRAINxy>; Tue, 9 Jan 2001 08:53:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129825AbRAINws>; Tue, 9 Jan 2001 08:52:48 -0500
Received: from zeus.kernel.org ([209.10.41.242]:28873 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S130032AbRAINwf>;
	Tue, 9 Jan 2001 08:52:35 -0500
Date: Tue, 9 Jan 2001 13:50:31 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        Stephen Tweedie <sct@redhat.com>
Subject: Re: `rmdir .` doesn't work in 2.4
Message-ID: <20010109135031.A4284@redhat.com>
In-Reply-To: <20010108185518.G27646@athlon.random> <Pine.GSO.4.21.0101081259230.4061-100000@weyl.math.psu.edu> <20010108213036.T27646@athlon.random> <93dicp$ano$1@penguin.transmeta.com> <20010109010125.O27646@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010109010125.O27646@athlon.random>; from andrea@suse.de on Tue, Jan 09, 2001 at 01:01:25AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jan 09, 2001 at 01:01:25AM +0100, Andrea Arcangeli wrote:
> On Mon, Jan 08, 2001 at 03:27:21PM -0800, Linus Torvalds wrote:
> > However, it is against all UNIX standards, and Linux-2.4 will explicitly
> 
> I may be missing something but apparently SuSv2 allows it, you can check here:
> 
> 	http://www.opengroup.org/onlinepubs/007908799/xsh/rmdir.html
> 
> Infact SuSv2 doesn't even allow rmdir to return -EINVAL.

SuS always allows implementations to return other errors than the ones
listed:

  Implementations will not generate a different error number from the
  ones described here for error conditions described in this
  specification, but may generate additional errors unless explicitly
  disallowed for a particular function.

See http://www.opengroup.org/onlinepubs/007908799/xsh/errors.html

--Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
