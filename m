Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131093AbRAULaa>; Sun, 21 Jan 2001 06:30:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131986AbRAULaU>; Sun, 21 Jan 2001 06:30:20 -0500
Received: from gnu.in-berlin.de ([192.109.42.4]:7430 "EHLO gnu.in-berlin.de")
	by vger.kernel.org with ESMTP id <S131093AbRAULaH>;
	Sun, 21 Jan 2001 06:30:07 -0500
X-Envelope-From: news@goldbach.in-berlin.de
To: linux-kernel@vger.kernel.org
Path: kraxel
From: Gerd Knorr <kraxel@bytesex.org>
Newsgroups: lists.linux.kernel
Subject: Re: Problems with Askey TView CPH061 grabber board under bttv
Date: 21 Jan 2001 10:44:25 GMT
Organization: Strusel 007
Message-ID: <slrn96lfc9.18a.kraxel@bogomips.masq.in-berlin.de>
In-Reply-To: <3A6AAC61.F8B850BC@coldfusion.4mg.com>
NNTP-Posting-Host: bogomips.masq.in-berlin.de
X-Trace: goldbach.masq.in-berlin.de 980073865 7988 192.168.69.77 (21 Jan 2001 10:44:25 GMT)
X-Complaints-To: news@goldbach.in-berlin.de
NNTP-Posting-Date: 21 Jan 2001 10:44:25 GMT
User-Agent: slrn/0.9.6.3 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This is very bizzare, as when I look at the debug output from the tuner
> module, it appears from the kernel messages that the card is being tuned
> to the correct frequency. I know there is a station on that frequency
> yet I
> don't get any picture or sound, so obviously the tuner driver is saying
> one thing and doing another.

It's likely it uses the wrong type.  Try picking another.

> Also, when the bttv driver loads, it detects the board as card number 38
> (Tview 99 CPH061x) when the card is really number 24 (Askey Magic TView
> CPH061x.)

Happens from time to time that vendors use the same PCI subsystem
ID for different cards.

  Gerd

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
