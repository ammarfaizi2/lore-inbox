Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284182AbSACJZN>; Thu, 3 Jan 2002 04:25:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285148AbSACJZG>; Thu, 3 Jan 2002 04:25:06 -0500
Received: from t2.redhat.com ([199.183.24.243]:48886 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S285161AbSACJYx>; Thu, 3 Jan 2002 04:24:53 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20020103040924.B6936@thyrsus.com> 
In-Reply-To: <20020103040924.B6936@thyrsus.com>  <20020102220333.A26713@thyrsus.com> <20020102211038.C21788@thyrsus.com> <Pine.LNX.4.33.0201030327501.5131-100000@Appserv.suse.de> <20020102220333.A26713@thyrsus.com> <4115.1010049288@redhat.com> 
To: esr@thyrsus.com
Cc: Dave Jones <davej@suse.de>, Lionel Bouton <Lionel.Bouton@free.fr>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems? 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 03 Jan 2002 09:24:40 +0000
Message-ID: <5536.1010049880@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


esr@thyrsus.com said:
>  You have my intentions backwards. What I'd like to be able to do is
> suppress ISA_SLOTS when there are detectably *no* ISA cards.
> Unfortunately I have had it demonstrated that the DMI tables can give
> false negatives (false positives would not have been a showstopper).

I suggest you just suppress it anyway unless you're in normal 
configuration mode. As you say - you don't need to care too much about 
ancient hardware, and if they have ISA cards they're going to _need_ to 
know what's in the box anyway. 

--
dwmw2


