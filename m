Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272182AbRHWBxS>; Wed, 22 Aug 2001 21:53:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272185AbRHWBxJ>; Wed, 22 Aug 2001 21:53:09 -0400
Received: from relay.eqip.net ([195.206.66.146]:12709 "HELO mailgate.eqip.net")
	by vger.kernel.org with SMTP id <S272182AbRHWBxE>;
	Wed, 22 Aug 2001 21:53:04 -0400
Path: Home.Lunix!not-for-mail
Subject: Re: /dev/random entropy calcs - patch [not related to net devices]
Date: Thu, 23 Aug 2001 01:53:07 +0000 (UTC)
Organization: lunix confusion services
In-Reply-To: <9547398.998437243@_169.254.198.40_>
NNTP-Posting-Host: kali.eth
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Trace: quasar.home.lunix 998531587 2919 10.253.0.3 (23 Aug 2001 01:53:07
    GMT)
X-Complaints-To: abuse-0@ton.iguana.be
NNTP-Posting-Date: Thu, 23 Aug 2001 01:53:07 +0000 (UTC)
X-Newsreader: knews 1.0b.0
Xref: Home.Lunix mail.linux.kernel:108082
X-Mailer: Perl5 Mail::Internet v1.33
Message-Id: <9m1nm3$2r7$1@post.home.lunix>
From: linux-kernel@ton.iguana.be (Ton Hospel)
To: linux-kernel@vger.kernel.org
Reply-To: linux-kernel@ton.iguana.be (Ton Hospel)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <9547398.998437243@_169.254.198.40_>,
	Alex Bligh - linux-kernel <linux-kernel@alex.org.uk> writes:
> 2. Anyone have any problem changing fs/proc/proc_misc.c to
>    register /proc/interrupts to be 0600 instead of 0644 to help
>    prevent entropy attacks that way?

Yes, i don't want to have to switch to root to read /proc/interrupts
because some people have gone utterly paranoid about an attack that's not
feasable if you reseed your randum numbers normally at boot.
