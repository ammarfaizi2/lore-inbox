Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129431AbRAJDYo>; Tue, 9 Jan 2001 22:24:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129764AbRAJDYe>; Tue, 9 Jan 2001 22:24:34 -0500
Received: from a203-167-249-89.reverse.clear.net.nz ([203.167.249.89]:58377
	"HELO metastasis.f00f.org") by vger.kernel.org with SMTP
	id <S129431AbRAJDYa>; Tue, 9 Jan 2001 22:24:30 -0500
Date: Wed, 10 Jan 2001 16:24:26 +1300
From: Chris Wedgwood <cw@f00f.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Dan Hollis <goemon@anime.net>, "David S. Miller" <davem@redhat.com>,
        stephenl@zeus.com, linux-kernel@vger.kernel.org
Subject: Re: [PLEASE-TESTME] Zerocopy networking patch, 2.4.0-1
Message-ID: <20010110162426.B9585@metastasis.f00f.org>
In-Reply-To: <Pine.LNX.4.30.0101091456160.7153-100000@anime.net> <Pine.LNX.4.30.0101092358000.9990-100000@e2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.30.0101092358000.9990-100000@e2>; from mingo@elte.hu on Tue, Jan 09, 2001 at 11:59:13PM +0100
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 09, 2001 at 11:59:13PM +0100, Ingo Molnar wrote:

    it's a bad name in that case. We dont 'send any file' if we in
    fact are receiving a data stream from a socket and writing it
    into a file :-)

so rename it -- user-space can retain the old name for compatibility
and new more sensible name


  --cw
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
