Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129429AbQLTJr3>; Wed, 20 Dec 2000 04:47:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129765AbQLTJrT>; Wed, 20 Dec 2000 04:47:19 -0500
Received: from baldur.fh-brandenburg.de ([195.37.0.5]:38349 "HELO
	baldur.fh-brandenburg.de") by vger.kernel.org with SMTP
	id <S129429AbQLTJrP>; Wed, 20 Dec 2000 04:47:15 -0500
Date: Wed, 20 Dec 2000 10:05:44 +0100 (MET)
From: Roman Zippel <zippel@fh-brandenburg.de>
To: Bernardo Innocenti <bernie@codewiz.org>
cc: LKML <linux-kernel@vger.kernel.org>,
        Linux/m68k <linux-m68k@lists.linux-m68k.org>,
        Hans-Joachim Widmaier <hjw@zvw.de>,
        "Erik I.Bolsø" <eriki@himolde.no>
Subject: Re: PROBLEM: mounting affs over loop hangs in syscall (x86 only?)
In-Reply-To: <00121822531900.23280@beetle>
Message-ID: <Pine.GSO.4.10.10012200957520.5330-100000@zeus.fh-brandenburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 18 Dec 2000, Bernardo Innocenti wrote:

> [1.] One line summary of the problem:
> mounting affs over loop hangs in syscall (x86 only?)

affs plays some games with the suberblock lock, I have a patch that plays
even worse games, but it works. I hope to finish a major cleanup of affs
over christmas.

bye, Roman

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
