Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131138AbRAZRo7>; Fri, 26 Jan 2001 12:44:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131648AbRAZRot>; Fri, 26 Jan 2001 12:44:49 -0500
Received: from adsl-63-204-197-52.dsl.snfc21.pacbell.net ([63.204.197.52]:27657
	"EHLO mail.topdollargeek.com") by vger.kernel.org with ESMTP
	id <S131138AbRAZRoe>; Fri, 26 Jan 2001 12:44:34 -0500
To: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
Subject: Re: 2.4.0 APM w/ Compaq 16xx laptop...
Message-ID: <980531042.3a71b762a10d1@www.sunshinecomputing.com>
Date: Fri, 26 Jan 2001 09:44:02 -0800 (PST)
From: Brian Macy <bmacy@macykids.net>
Cc: Brian Macy <bmacy@macykids.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <978926262.3a593ab671347@www.sunshinecomputing.com> <20010108221544.Z3472@arthur.ubicom.tudelft.nl>
In-Reply-To: <20010108221544.Z3472@arthur.ubicom.tudelft.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: IMP/PHP IMAP webmail program 2.2.3
X-Originating-IP: 207.33.153.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the suggestion. Actually got around to trying it... didn't work. But
the other thing is that the laptop doesn't support ACPI, just APM.

Brian Macy

Quoting Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>:

> On Sun, Jan 07, 2001 at 07:57:42PM -0800, Brian Macy wrote:
> > Anyone get this working? If so please tell me the version of you APM
> utilities
> > and what Power Management options you have on in the kernel.
> >
> > Ever since I started trying 2.3.x, as soon as the box gets a change in
> it's
> > power status (even just an update of the % battery) Linux locks solid.
> It's 100%
> > repeatable.
>
> Sounds like the kernel is using ACPI reserved memory, so the first ACPI
> event corrupts kernel memory and the kernel locks up.
>
> I've seen similar problems with an IBM ThinkPad 600X, but it was fixed
> somewhere in 2.4.0-pre12-test7. Try linux-2.4.0, if that doesn't work,
> boot the kernel with "mem=1MB-less-than-the-machine-actually-has", so
> for a 128MB machine, try "mem=127M".
>
>
> Erik
>
> --
> J.A.K. (Erik) Mouw, Information and Communication Theory Group,
> Department
> of Electrical Engineering, Faculty of Information Technology and
> Systems,
> Delft University of Technology, PO BOX 5031,  2600 GA Delft, The
> Netherlands
> Phone: +31-15-2783635  Fax: +31-15-2781843  Email:
> J.A.K.Mouw@its.tudelft.nl
> WWW: http://www-ict.its.tudelft.nl/~erik/
>
>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
