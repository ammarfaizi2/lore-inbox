Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129153AbQKXEph>; Thu, 23 Nov 2000 23:45:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129996AbQKXEp1>; Thu, 23 Nov 2000 23:45:27 -0500
Received: from a203-167-249-89.reverse.clear.net.nz ([203.167.249.89]:6663
        "HELO metastasis.f00f.org") by vger.kernel.org with SMTP
        id <S129632AbQKXEpP>; Thu, 23 Nov 2000 23:45:15 -0500
Date: Fri, 24 Nov 2000 17:15:11 +1300
From: Chris Wedgwood <cw@f00f.org>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Bernd Eckenfels <ecki@lina.inka.de>, linux-kernel@vger.kernel.org
Subject: Re: beware of dead string constants
Message-ID: <20001124171511.B26050@metastasis.f00f.org>
In-Reply-To: <E13z5nt-0007ig-00@calista.inka.de> <3A1DAAAD.28786302@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A1DAAAD.28786302@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Thu, Nov 23, 2000 at 06:39:25PM -0500
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2000 at 06:39:25PM -0500, Jeff Garzik wrote:

    Advantage of what?
    
    If you mean preferring 'if ()' over 'ifdef'... Linus.  :)  And I agree
    with him:  code looks -much- more clean without ifdefs.  And the
    compiler should be smart enough to completely eliminate code inside an
    'if (0)' code block.

Not only that; we should move to code where the compiler engine can
sanitize the code; the preprocessor alternative is obviously more
limited here.

The same can also be said for some of the many macro's that are
#defined; some would surely be better as inline functions is we could
ensure they would always be in-lined.



  --cw
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
