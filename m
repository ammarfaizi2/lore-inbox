Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262779AbREOPUC>; Tue, 15 May 2001 11:20:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262780AbREOPTw>; Tue, 15 May 2001 11:19:52 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:39372 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S262779AbREOPTd>;
	Tue, 15 May 2001 11:19:33 -0400
Message-ID: <3B014903.B16B650B@mandrakesoft.com>
Date: Tue, 15 May 2001 11:19:31 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Neil Brown <neilb@cse.unsw.edu.au>,
        "H. Peter Anvin" <hpa@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        viro@math.psu.edu
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <Pine.LNX.4.21.0105150811170.1802-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Tue, 15 May 2001, Alan Cox wrote:
> >
> > For block devices that seems to work well. char devices are harder and I'd
> > rather issue the occasional new major than have people registering automatic
> > cabbage slicers as a tty or a disk because they cant get a device id.
> 
> What are the valid cases that couldn't just register as a misc'ish
> driver? The one that stands out is serial devices (you have hundreds of
> them), but that's the same argument as a disk anyway.

/dev/fbN, /dev/dspN, /dev/videoN, ...

-- 
Jeff Garzik      | Game called on account of naked chick
Building 1024    |
MandrakeSoft     |
