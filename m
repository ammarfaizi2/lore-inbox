Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132002AbRAQG4h>; Wed, 17 Jan 2001 01:56:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132575AbRAQG41>; Wed, 17 Jan 2001 01:56:27 -0500
Received: from mailgate.att-unisource.net ([195.206.66.146]:8625 "HELO
	mailgate.eqip.net") by vger.kernel.org with SMTP id <S132002AbRAQG4O>;
	Wed, 17 Jan 2001 01:56:14 -0500
Path: Home.Lunix!not-for-mail
Subject: Re: Is sendfile all that sexy?
Date: Wed, 17 Jan 2001 06:56:09 +0000 (UTC)
Organization: lunix confusion services
In-Reply-To: <UTC200101161350.OAA141869.aeb@ark.cwi.nl>
NNTP-Posting-Host: kali.eth
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Trace: quasar.home.lunix 979714569 26234 10.253.0.3 (17 Jan 2001
    06:56:09 GMT)
X-Complaints-To: abuse-0@ton.iguana.be
NNTP-Posting-Date: Wed, 17 Jan 2001 06:56:09 +0000 (UTC)
X-Newsreader: knews 1.0b.0
Xref: Home.Lunix mail.linux.kernel:69993
X-Mailer: Perl5 Mail::Internet v1.32
Message-Id: <943fm9$pjq$1@post.home.lunix>
From: linux-kernel@ton.iguana.be (Ton Hospel)
To: linux-kernel@vger.kernel.org
Reply-To: linux-kernel@ton.iguana.be (Ton Hospel)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <UTC200101161350.OAA141869.aeb@ark.cwi.nl>,
	Andries.Brouwer@cwi.nl writes:
> 
> I am afraid I have missed most earlier messages in this thread.
> However, let me remark that the problem of assigning a
> file descriptor is the one that is usually described by
> "priority queue". The version of Peter van Emde Boas takes
> time O(loglog N) for both open() and close().
> Of course this is not meant to suggest that we use it.
> 
Fascinating ! But how is this possible ? What stops me from
using this algorithm from entering N values and extracting 
them again in order and so end up with a O(N*log log N)
sorting algorithm ? (which would be better than log N! ~ N*logN)

(at least the web pages I found about this seem to suggest you
can use this on any set with a full order relation)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
