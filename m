Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277366AbRJOKE6>; Mon, 15 Oct 2001 06:04:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277369AbRJOKEs>; Mon, 15 Oct 2001 06:04:48 -0400
Received: from web11903.mail.yahoo.com ([216.136.172.187]:45585 "HELO
	web11903.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S277366AbRJOKEc>; Mon, 15 Oct 2001 06:04:32 -0400
Message-ID: <20011015100504.94918.qmail@web11903.mail.yahoo.com>
Date: Mon, 15 Oct 2001 03:05:04 -0700 (PDT)
From: Kirill Ratkin <kratkin@yahoo.com>
Subject: Re: how to let audio work on intel i810
To: Barry Wu <wqb123@yahoo.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20011015093240.93914.qmail@web13907.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi. It's easy:
You have to have modules:
i810_audio             17456   1
ac97_codec              9488   0 [i810_audio]

It's configured options:
CONFIG_SOUND_ICH=m
CONFIG_SOUND_ES1371=m

ES1371 is Audio Codec 97

Regards,
Kirill.

--- Barry Wu <wqb123@yahoo.com> wrote:
> 
> Hi, all,
> 
> I have installed redhat7.1 on my intel i810
> system. But the audio can not work. Does
> it need some patches? If someone knows, please
> help me. Thanks.
> 
> Barry
> 
> __________________________________________________
> Do You Yahoo!?
> Make a great connection at Yahoo! Personals.
> http://personals.yahoo.com
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


__________________________________________________
Do You Yahoo!?
Make a great connection at Yahoo! Personals.
http://personals.yahoo.com
