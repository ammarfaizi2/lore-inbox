Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133086AbQLIBfy>; Fri, 8 Dec 2000 20:35:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135219AbQLIBfo>; Fri, 8 Dec 2000 20:35:44 -0500
Received: from quattro.sventech.com ([205.252.248.110]:49675 "HELO
	quattro.sventech.com") by vger.kernel.org with SMTP
	id <S133086AbQLIBfa>; Fri, 8 Dec 2000 20:35:30 -0500
Date: Fri, 8 Dec 2000 20:05:04 -0500
From: Johannes Erdfelt <johannes@erdfelt.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB-related lockup in test12-pre5
Message-ID: <20001208200504.G15095@sventech.com>
In-Reply-To: <20001207134013.L935@sventech.com> <Pine.LNX.4.30.0012082321160.1107-100000@imladris.demon.co.uk> <20001208195437.E15095@sventech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4i
In-Reply-To: <20001208195437.E15095@sventech.com>; from Johannes Erdfelt on Fri, Dec 08, 2000 at 07:54:38PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2000, Johannes Erdfelt <johannes@erdfelt.com> wrote:
> On Fri, Dec 08, 2000, David Woodhouse <dwmw2@infradead.org> wrote:
> > On Thu, 7 Dec 2000, Johannes Erdfelt wrote:
> > 
> > > Could you try the alternate UHCI driver? You may need to disable the
> > > UHCI driver you have configured for the option to become visible.
> > 
> > Differently broken:
> > 	uhci: host controller process error. something bad happened
> > 	uhci: host controller halted. very bad
> > 
> > ... but at least the machine doesn't die. This was working in test11,
> > IIRC. Certainly in test10.
> 
> I'm sure you can guess from the messages that we have a problem.
> 
> However, I haven't seen that error in a long time. Lemme go back and
> look in the docs to see if I can get some more information as to why
> that would actually happen.

Actually, looking back at your previous email, enabling bus mastering
may make this error go away.

Could you give -pre7 a try? Or have you already?

JE

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
