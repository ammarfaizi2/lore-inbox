Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129476AbQLBF1x>; Sat, 2 Dec 2000 00:27:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129913AbQLBF1n>; Sat, 2 Dec 2000 00:27:43 -0500
Received: from a203-167-249-89.reverse.clear.net.nz ([203.167.249.89]:2564
	"HELO metastasis.f00f.org") by vger.kernel.org with SMTP
	id <S129476AbQLBF1d>; Sat, 2 Dec 2000 00:27:33 -0500
Date: Sat, 2 Dec 2000 17:57:04 +1300
From: Chris Wedgwood <cw@f00f.org>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Steven Van Acker <deepstar@ulyssis.org>, linux-kernel@vger.kernel.org,
        "Stephen C. Tweedie" <sct@redhat.com>
Subject: Re: ext2 directory size bug (?)
Message-ID: <20001202175704.B269@metastasis.f00f.org>
In-Reply-To: <Pine.LNX.4.21.0011300453200.31229-100000@ace.ulyssis.org> <Pine.LNX.3.95.1001130081717.723A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.3.95.1001130081717.723A-100000@chaos.analogic.com>; from root@chaos.analogic.com on Thu, Nov 30, 2000 at 08:24:02AM -0500
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2000 at 08:24:02AM -0500, Richard B. Johnson wrote:

    This is actually a feature. The directory does not get truncated.

Arguably directories could be truncated when objects towards the end
are removed; I believe UFS under Solaris might do this? 

An even better heuristic I like would allow repacking of a directory
and truncation if you could safely half the size -- but I suspect
locking issues might be hideous here.


  --cw
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
