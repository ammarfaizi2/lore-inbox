Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129752AbQL1Da6>; Wed, 27 Dec 2000 22:30:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129667AbQL1Dar>; Wed, 27 Dec 2000 22:30:47 -0500
Received: from a203-167-249-89.reverse.clear.net.nz ([203.167.249.89]:20231
	"HELO metastasis.f00f.org") by vger.kernel.org with SMTP
	id <S131105AbQL1Daf>; Wed, 27 Dec 2000 22:30:35 -0500
Date: Thu, 28 Dec 2000 16:00:05 +1300
From: Chris Wedgwood <cw@f00f.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Rik van Riel <riel@conectiva.com.br>, Alexander Viro <viro@math.psu.edu>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: innd mmap bug in 2.4.0-test12
Message-ID: <20001228160005.B14479@metastasis.f00f.org>
In-Reply-To: <20001227235533.T21944@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.10.10012271626040.10569-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10012271626040.10569-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Wed, Dec 27, 2000 at 04:27:06PM -0800
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(cc' list trimmed)

On Wed, Dec 27, 2000 at 04:27:06PM -0800, Linus Torvalds wrote:

    ramfs. It doesn't have a writepage() function, as there is no
    backing store.

this remind me; perhaps you or Al could answer this.

  How hard would it be to have ramfs backed by swap? The goal being
  try to achieve something like a FreeBSDs mfs.

I use ramfs for /tmp on my laptop -- it's very handy because it
extends the amount of the the disk had spent spun down and therefore
battery life; but writing large files into /tmp can blow away the
system or at the very least eat away at otherwise usable ram. Not
terribly desirable.



  --cw
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
