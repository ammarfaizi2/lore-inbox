Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285482AbSAGTZB>; Mon, 7 Jan 2002 14:25:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285516AbSAGTYw>; Mon, 7 Jan 2002 14:24:52 -0500
Received: from iwd_mail.intware.com ([216.94.87.36]:61968 "EHLO
	iwd_mail.intware.com") by vger.kernel.org with ESMTP
	id <S285482AbSAGTXo> convert rfc822-to-8bit; Mon, 7 Jan 2002 14:23:44 -0500
Message-ID: <F7EB06D3ED62D311A15600104B6D909F442058@IWD_MAIL>
From: Dimitrie Paun <dimi@intelliware.ca>
To: "'Linus Torvalds'" <torvalds@transmeta.com>,
        Abramo Bagnara <abramo@alsa-project.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Christoph Hellwig <hch@ns.caldera.de>,
        Jaroslav Kysela <perex@suse.cz>, sound-hackers@zabbo.net,
        linux-sound@vger.rutgers.edu, linux-kernel@vger.kernel.org
Subject: RE: [s-h] Re: ALSA patch for 2.5.2pre9 kernel
Date: Mon, 7 Jan 2002 14:03:26 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Linus Torvalds [mailto:torvalds@transmeta.com]
> 
> This is my current feeling.
> 
> However, la donna é mobile, and I'm a primus donna, fer 
> shure. So don't take it _too_ seriously, continue to argue 
> the merits of other approaches.

That's good to know. So let's do so:

There is no one grouping: things can be grouped in any number 
of ways, and for this very reason, a strictly hierarchical
grouping does not cut it. What I'm trying to say is that at
certain point, a given grouping characteristics becomes less 
important (say sound) and other (which crosscut other parts of
the source) increase in importance (say drivers).

For this reason, I think the current organization (net/core +
drivers/net) is more practical then the one which initially 
screams at any CompSci guy (net/core + net/drivers). 

Now, whichever one we choose, I'd _hate_ to see net organized
one way and sound the other way. It would be just ugly. That,
together with the fact that I don't think that putting everything
under sound/ is in any way superior to the current method,
I would suggest we stick to: sound/core + drivers/sound.

--
Dimi.
