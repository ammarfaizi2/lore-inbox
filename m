Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129259AbRBIU4G>; Fri, 9 Feb 2001 15:56:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130439AbRBIUz4>; Fri, 9 Feb 2001 15:55:56 -0500
Received: from pcow034o.blueyonder.co.uk ([195.188.53.122]:61444 "EHLO
	blueyonder.co.uk") by vger.kernel.org with ESMTP id <S129259AbRBIUzm>;
	Fri, 9 Feb 2001 15:55:42 -0500
Message-ID: <004901c092da$7ed9c260$875b1f3e@speedo>
From: "Duncan Gauld" <dg010a0001@blueyonder.co.uk>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <20010209144534.B379@bella.auschron.com>
Subject: Re: booting the 2.4.1 linux kernel... tada,nada
Date: Fri, 9 Feb 2001 20:54:29 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

a couple of things to check here.
a) when compiling the kernel, did you remember to select the proper CPU in
the kernel config?
b) if you are using (for example) an ATI Rage 128 you need to go into
character devices and say Y to DRI X and ATI Rage 128.
(I found that the latter idea fixed the same problem on my machine.)

I'm a newbie, 12, so hope this helps!

Duncan

Lyndsey Simon wrote:

> [1.] Once I get the loading the kernel message from Lilo I hard crash
without any error
> messages.
> [2.] I had no trouble making the bzImage and have installed it made it and
installed it
> three different times from scratch, once using debian's make-kpkg tool,
but still I get
> the same outcome - a hard crash with no error messages. I get the Loading
> Linux.2.4.1........... ok,now booting the kernel and then BANG, I go dead
with no error
> message of any kind.

<snip>



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
