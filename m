Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129104AbQKFOQh>; Mon, 6 Nov 2000 09:16:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129529AbQKFOQ1>; Mon, 6 Nov 2000 09:16:27 -0500
Received: from ppp-96-107-an01u-dada6.iunet.it ([151.35.96.107]:55812 "HELO
	home.bogus") by vger.kernel.org with SMTP id <S129510AbQKFOQR>;
	Mon, 6 Nov 2000 09:16:17 -0500
From: Davide Libenzi <davidel@xmail.virusscreen.com>
To: George Talbot <george@brain.moberg.com>,
        "Theodore Y. Ts'o" <tytso@MIT.EDU>
Subject: Re: Can EINTR be handled the way BSD handles it? -- a plea from a user-land
Date: Mon, 6 Nov 2000 16:30:03 +0100
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
Cc: Tim Hockin <thockin@isunix.it.ilstu.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0011060824000.4984-100000@brain.moberg.com>
In-Reply-To: <Pine.LNX.4.21.0011060824000.4984-100000@brain.moberg.com>
MIME-Version: 1.0
Message-Id: <00110616325700.00204@linux1.home.bogus>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Nov 2000, George Talbot wrote:
> On Fri, 3 Nov 2000, Theodore Y. Ts'o wrote:
> 
> >    Date: 	Fri, 03 Nov 2000 14:44:17 -0500
> >    From: george@moberg.com
> > 
> >    My problem is that pthread_create (glibc 2.1.3, kernel 2.2.17 i686) is
> >    failing because, deep inside glibc somewhere, nanosleep() is returning
> >    EINTR.
> > 

I've lost previous messages but have You tried :

man siginterrupt


- Davide
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
