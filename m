Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281614AbRKMMKT>; Tue, 13 Nov 2001 07:10:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281615AbRKMMKK>; Tue, 13 Nov 2001 07:10:10 -0500
Received: from mail.terraempresas.com.br ([200.177.96.20]:47120 "EHLO
	mail.terraempresas.com.br") by vger.kernel.org with ESMTP
	id <S281614AbRKMMJx>; Tue, 13 Nov 2001 07:09:53 -0500
Message-ID: <004601c16c3c$8f865e70$1300a8c0@marcelo>
From: "Marcelo Borges Ribeiro" <marcelo@datacom-telematica.com.br>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <20011112220630.A1200@bruder.net> <20011113121907.A9058@telia.com>
Subject: Re: via82cxxx_audio problems
Date: Tue, 13 Nov 2001 10:08:29 -0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The problem with via82xx is that it is locked in 48000Hz (you can see this
in dmesg) and cannot play in any other rate. With mplayer you can see
messages such as requested 16000Hz got (480000) that explains why it sounds
like chip'n'dale ;-). P.s. I don´t know why it works with xmms  but with
mpg123 it refuses to play at all becouse these sound rates.
----- Original Message -----
From: "André Dahlqvist" <andre.dahlqvist@telia.com>
To: <linux-kernel@vger.kernel.org>
Sent: Tuesday, November 13, 2001 9:19 AM
Subject: Re: via82cxxx_audio problems


> sergio@bruder.net <sergio@bruder.net> wrote:
>
> > With rapid fast-forward in mplayer, The sound just mutes itself and
> > mplayer just crawls down to 1-2 frames per second. Looking at
> > /var/log/messages Ive got:
>
> Try the latest 2.4.15-preX kernel since that has a much newer VIA audio
> driver which might fix this.
> --
>
> André Dahlqvist <andre.dahlqvist@telia.com>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

