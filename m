Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291767AbSBHTgE>; Fri, 8 Feb 2002 14:36:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291771AbSBHTfy>; Fri, 8 Feb 2002 14:35:54 -0500
Received: from pop.gmx.de ([213.165.64.20]:44872 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S291767AbSBHTfl>;
	Fri, 8 Feb 2002 14:35:41 -0500
Message-ID: <00c301c1b0d7$d1f07ae0$4e492e3e@angband>
Reply-To: "Andreas Happe" <andreashappe@subdimension.com>
From: "Andreas Happe" <andreashappe@gmx.net>
To: "lkml" <linux-kernel@vger.kernel.org>, "Dave Jones" <davej@suse.de>
In-Reply-To: <000c01c1b0bf$567ab910$704e2e3e@angband> <20020208180216.H32413@suse.de>
Subject: Re: boot problems using 2.5.3-dj3 || -dj4
Date: Fri, 8 Feb 2002 20:34:41 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, Feb 08, 2002 at 05:40:35PM +0100, Andreas Happe wrote:
>  > From: "Andreas Happe" <andreashappe@gmx.net>
[...]
>  > sorry, with dj4 modprobe dies with the error message
>  > "PAP-14030: direct2indirect: posted or inserted byte exists in the
>  > treeinvalid operand: 0000"
>
>  Ok, that's one for Oleg & Co to take a look at.
>  Can you run the oops dump through ksymoops ?
>

the error occurs in  ./fs/reiserfs/tail-conversion.c .
the kernel oops jumped to another position by now, but it is still the same
error message. I'm using a reiserfs root position.

> --
> | Dave Jones.        http://www.codemonkey.org.uk
> | SuSE Labs
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


