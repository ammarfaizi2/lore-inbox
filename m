Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265577AbRF1HVg>; Thu, 28 Jun 2001 03:21:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265580AbRF1HV1>; Thu, 28 Jun 2001 03:21:27 -0400
Received: from nwcst31h.netaddress.usa.net ([204.68.23.63]:53988 "HELO
	nwcst318.netaddress.usa.net") by vger.kernel.org with SMTP
	id <S265577AbRF1HVV> convert rfc822-to-8bit; Thu, 28 Jun 2001 03:21:21 -0400
Message-ID: <20010628072120.7126.qmail@nwcst318.netaddress.usa.net>
Date: 28 Jun 2001 01:21:20 MDT
From: Blesson Paul <blessonpaul@usa.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [Re: kernel2.4 is not working]
X-Mailer: USANET web-mailer (34FM.0700.17C.01)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
                      I found out the problem. The reason is that the
kernel(linux-2.4.5) is not present in the /boot directory. But I had
uncommented the export statement of INSTALL_PATH=/boot. But the linux kernel
is not put in the /boot directory. why is it so. Presently the kernel is put
in the directory where i compiled. Unfortnately it is a NFS directory. I think
the place where linux kernel is found is hardcoded in boot
loader(linuz-2.4.5). Moreover one warning is comming always. "CLockskew
detected Your compilation may be incomplete". How to get rid of that
			by
                             Blesson Paul


"Alexander V. Bilichenko" <dmor@7ka.mipt.ru> wrote:
"not working"?
can You post there exactly crash info?
Best regards,
Alexander         mailto:dmor@7ka.mipt.ru
                         mailto:alexb@kernel.org
------------------------------------------------------
Let's start the war, said Meggy
------------------------------------------------------
----- Original Message -----
From: "Blesson Paul" <blessonpaul@usa.net>
To: <linux-kernel@vger.kernel.org>
Sent: Wednesday, June 27, 2001 6:08 PM
Subject: kernel2.4 is not working


> hi all
>                     Presnently I am using 2.2.16. Now I downloaded the
2.4.5
> kernel source code. Now I compiled it. I didn't changed anything in the
> menuconfig. Still it not working. Why it it so
>                by
>                    Blesson
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

