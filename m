Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130290AbQLEOjs>; Tue, 5 Dec 2000 09:39:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130484AbQLEOji>; Tue, 5 Dec 2000 09:39:38 -0500
Received: from a203-167-249-89.reverse.clear.net.nz ([203.167.249.89]:43268
	"HELO metastasis.f00f.org") by vger.kernel.org with SMTP
	id <S130290AbQLEOjU>; Tue, 5 Dec 2000 09:39:20 -0500
Date: Wed, 6 Dec 2000 03:08:50 +1300
From: Chris Wedgwood <cw@f00f.org>
To: John Meikle <linux@procom.demon.co.uk>
Cc: "Stephen C. Tweedie" <sct@redhat.com>,
        Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: Re: Using map_user_kiobuf()
Message-ID: <20001206030850.A4661@metastasis.f00f.org>
In-Reply-To: <20001204215334.B9238@redhat.com> <NEBBIIEABDPEIPKIJFDOGEFLDGAA.linux@procom.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <NEBBIIEABDPEIPKIJFDOGEFLDGAA.linux@procom.demon.co.uk>; from linux@procom.demon.co.uk on Tue, Dec 05, 2000 at 10:15:55AM -0000
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2000 at 10:15:55AM -0000, John Meikle wrote:

    Changing the WRITE to READ does solve the problem, thank you.
    
    I am still confused about why the code failed the way it did.  The module
    managed to write to the full 1,000,000, and the user programme could read it
    and verify it was correct.  Just nothing else worked after that!
    
    Am I the only one who finds the READ/WRITE option back to front?
    
No, I was just thinking it should be change to USER_READ, USER_WRITE
or something a little more obvious. 

Stephen?



  --cw
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
