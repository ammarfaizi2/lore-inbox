Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132601AbRAGOID>; Sun, 7 Jan 2001 09:08:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132793AbRAGOHx>; Sun, 7 Jan 2001 09:07:53 -0500
Received: from a203-167-249-89.reverse.clear.net.nz ([203.167.249.89]:28933
	"HELO metastasis.f00f.org") by vger.kernel.org with SMTP
	id <S132601AbRAGOHi>; Sun, 7 Jan 2001 09:07:38 -0500
Date: Mon, 8 Jan 2001 03:07:35 +1300
From: Chris Wedgwood <cw@f00f.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexander Viro <viro@math.psu.edu>,
        Stefan Traby <stefan@hello-penguin.com>, linux-kernel@vger.kernel.org
Subject: Re: ramfs problem... (unlink of sparse file in "D" state)
Message-ID: <20010108030735.B2844@metastasis.f00f.org>
In-Reply-To: <m1r92fj10c.fsf@frodo.biederman.org> <E14FGK1-0002gX-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14FGK1-0002gX-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sun, Jan 07, 2001 at 01:57:17PM +0000
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 07, 2001 at 01:57:17PM +0000, Alan Cox wrote:

    Rather more than that, and it only fixes those using
    generic_file_*

So we have common code that both generic_file_* calls and block_*
calls to check against -- how does that sound?

.. or we can check 'up one level' by adding another method to struct
file_operations perhaps (gross?).


  --cw

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
