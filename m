Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266330AbUALOat (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 09:30:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266355AbUALOat
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 09:30:49 -0500
Received: from smtp106.mail.sc5.yahoo.com ([66.163.169.226]:19803 "HELO
	smtp106.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266330AbUALOar convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 09:30:47 -0500
From: Murilo Pontes <murilo_pontes@yahoo.com.br>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: BUG: The key "/ ?" on my abtn2 keyboard is dead with kernel 2.6.1
Date: Mon, 12 Jan 2004 11:30:56 +0000
User-Agent: KMail/1.5.94
References: <200401111545.59290.murilo_pontes@yahoo.com.br> <20040111235025.GA832@ucw.cz>
In-Reply-To: <20040111235025.GA832@ucw.cz>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200401121130.56427.murilo_pontes@yahoo.com.br>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I try your patch:
> diff -Nru a/drivers/char/keyboard.c b/drivers/char/keyboard.c
> --- a/drivers/char/keyboard.c   Sun Jan 11 19:42:55 2004
> +++ b/drivers/char/keyboard.c   Sun Jan 11 19:42:55 2004
> @@ -941,8 +941,8 @@
>          32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47,
>          48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63,
>          64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79,
> -        80, 81, 82, 83, 84, 93, 86, 87, 88, 94, 95, 85,259,375,260, 90,
> -       284,285,309,311,312, 91,327,328,329,331,333,335,336,337,338,339,
> +        80, 81, 82, 83, 43, 93, 86, 87, 88, 94, 95, 85,259,375,260, 90,
> +       284,285,309,298,312, 91,327,328,329,331,333,335,336,337,338,339,
>         367,288,302,304,350, 89,334,326,116,377,109,111,126,347,348,349,
>         360,261,262,263,298,376,100,101,321,316,373,286,289,102,351,355,
>         103,104,105,275,287,279,306,106,274,107,294,364,358,363,362,361,
but key not work!

I try showkey program under console-framebuffer and under xterm-console, 
output in both modes:
keycode  53 release

If key is read on console-framebuffer, why it not printed in screen?


Thanks,
Murilo Pontes
