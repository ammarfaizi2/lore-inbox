Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262141AbRETS6s>; Sun, 20 May 2001 14:58:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262139AbRETS6i>; Sun, 20 May 2001 14:58:38 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:25354 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S262138AbRETS63>;
	Sun, 20 May 2001 14:58:29 -0400
Date: Sun, 20 May 2001 19:57:51 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Richard Gooch <rgooch@ras.ucalgary.ca>, Matthew Wilcox <matthew@wil.cx>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Alexander Viro <viro@math.psu.edu>, Andrew Clausen <clausen@gnu.org>,
        Ben LaHaise <bcrl@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFD w/info-PATCH] device arguments from lookup, partion code
Message-ID: <20010520195751.B1143@flint.arm.linux.org.uk>
In-Reply-To: <20010520112351.A32544@flint.arm.linux.org.uk> <Pine.LNX.4.21.0105201144580.7553-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0105201144580.7553-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Sun, May 20, 2001 at 11:46:33AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 20, 2001 at 11:46:33AM -0700, Linus Torvalds wrote:
> Nobody will expect the above to work, and everybody will agree that the
> above is a BUG if the read() call will actually follow the pointer.

I didn't say anything about read().  I said write().  Obviously it
wouldn't work for read()!

> Read my email. And read the last line: "psychology is important".

I did.  I also know that if you give the world enough rope, someone
will hang themselves.

(Note that because I've thought a way of misusing this in the same
was as ioctl, you can bet your bottom dollar that other people will).

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

