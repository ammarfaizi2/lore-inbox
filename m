Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132896AbRAUAe7>; Sat, 20 Jan 2001 19:34:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132762AbRAUAeu>; Sat, 20 Jan 2001 19:34:50 -0500
Received: from a203-167-249-89.reverse.clear.net.nz ([203.167.249.89]:5636
	"HELO metastasis.f00f.org") by vger.kernel.org with SMTP
	id <S132896AbRAUAef>; Sat, 20 Jan 2001 19:34:35 -0500
Date: Sun, 21 Jan 2001 13:34:33 +1300
From: Chris Wedgwood <cw@f00f.org>
To: Dan Maas <dmaas@dcine.com>
Cc: Edgar Toernig <froese@gmx.de>, Michael Lindner <mikel@att.net>,
        linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: select() on TCP socket sleeps for 1 tick even if data  available
Message-ID: <20010121133433.A1112@metastasis.f00f.org>
In-Reply-To: <fa.nc2eokv.1dj8r80@ifi.uio.no> <fa.dcei62v.1s5scos@ifi.uio.no> <015e01c082ac$4bf9c5e0$0701a8c0@morph> <3A69361F.EBBE76AA@att.net> <20010120200727.A1069@metastasis.f00f.org> <3A694254.B52AE20B@att.net> <3A6A09F2.8E5150E@gmx.de> <022f01c08342$088f67b0$0701a8c0@morph>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <022f01c08342$088f67b0$0701a8c0@morph>; from dmaas@dcine.com on Sat, Jan 20, 2001 at 07:35:12PM -0500
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 20, 2001 at 07:35:12PM -0500, Dan Maas wrote:
    
    Bingo! With this fix, 2.2.18 performance becomes almost identical to 2.4.0
    performance. I assume 2.4.0 disables Nagle by default on local
    connections...

2.4.x has a smarter nagle algorithm.



  --cw

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
