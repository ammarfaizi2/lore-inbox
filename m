Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264101AbUFBUwf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264101AbUFBUwf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 16:52:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264132AbUFBUwe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 16:52:34 -0400
Received: from chaos.analogic.com ([204.178.40.224]:9344 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264101AbUFBUwM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 16:52:12 -0400
Date: Wed, 2 Jun 2004 16:52:04 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Garboua Nahil Y Contr WRALC/MASFE <Nahil.Garboua@robins.af.mil>
cc: Mathieu Segaud <matt@minas-morgul.org>, linux-kernel@vger.kernel.org
Subject: RE: Context switch Tick
In-Reply-To: <200406022013.i52KDu1l025256@cits-darla.robins.af.mil>
Message-ID: <Pine.LNX.4.53.0406021650150.1020@chaos>
References: <200406022013.i52KDu1l025256@cits-darla.robins.af.mil>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1678434306-347682473-1086209524=:1020"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--1678434306-347682473-1086209524=:1020
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Wed, 2 Jun 2004, Garboua Nahil Y Contr WRALC/MASFE wrote:

> Okay, vmstat show me the cs according to current load, what is the Maximum
> tick rate?
> A process requests a 1 microseconds sleep, or even 500 nanoseconds, how long
> does it actually sleep, that is why I need to know max tick rate for context
> switch for a given CPU.

Can't you just measure it?

Script started on Wed Jun  2 16:48:51 2004
# ./tester
Testing CPU Speed (once at start of program)
CPU speed = 2803766848 Hz
Cycles to make the two function calls = 88
It took 55625156 cpu cycles or 19839.437091 microseconds.
# exit
Script done on Wed Jun  2 16:48:57 2004

That was for a usleep(1). Source attached.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.


--1678434306-347682473-1086209524=:1020
Content-Type: APPLICATION/octet-stream; name="context.tar.gz"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.53.0406021652040.1020@chaos>
Content-Description: 
Content-Disposition: attachment; filename="context.tar.gz"

H4sIAII9vkAAA+1XbW/bNhD2V/FXHBoYsANbluKXDMk6DMuHrgPWDk2HftiG
gKYoiwhNGiQVxx3633uULL/Fbb6kHYLxgWGLp4f34jveSUwrx+/djRNzPmh9
G8AoOR+PoQUeycHvepEmyfh8NJyMh2OANB2fn7Vg/I382UNpHTUALaO1+xrv
sfvPFGw3/7/TW54LyZ/YBuZ2Mhp9Of/peJv/JElQMDybTFqQPLEfR/E/zz+h
Ul5EjlvHDSH1b7OOGZjMWRZfk2jGGPTfnkH/A26AvoaaAg+YhElO1QWJzBz6
OTSa/+s4A45j7/yvc/jUNh45/2l6Njo8/2k6DOf/e+CEnETvC2EBP7nhHKzO
3ZIaDksjnOMKpit4J1hBTQa/xPCbLpTVKoY3GncyvVgZMSuc384kxSLKYnhd
Lam0GpR2MCupoVhlPAOnIdNA1coVQs1QQWl5XsqYoBuExBl1lEhqHbakWGo1
i5JqWWyXsa9WElMpZir6ISLxTOqpjLB88dZqwcFf/pyXijmhFfGKAd5xVxoF
ruBw9cef6Khmt5CJPOeGK8Zhyt2SY6i2ZIxbK+44MGxz1vuF6i6iRWkLGbX5
9B77mj8kJJrrOxl1Kme7PfC3ougEXnEHXgZSL8G7vNQm2yUXFZntkwv8Cw/Z
bU7ve7A24NnX1LtVGnT5qPo2z5oNxcMNByZsOa3j8d7QypurNbNf+YSUaUVh
FSW7rzXOsS6EK2CqjdFLEi30YvO/cMwLV1no9c8Je/2/GeZPbOOx/j8anW/6
P74q+P4/HI1D//8ewA4pFJNlxuFH6zKh4+KnfZEU031ZqQSKvYxg5XBsrKWy
2I6xv/sGU39hPXW6lxvGnRYZWFbw7GYluMw6XuDvC+w4cypUx19QM7M98LMG
TvH67q9/uuRf4mvkiAW2KG/sAqdKD5zr+YYtppcVOdPY3TjgbGFowUtqc7VP
zVvH4BReK+EE7vvI4XRQESst8BJ2qUi88mJDHYdmsvT9gKinyQqfeG2jYGEw
kLzz4j0eJRxxFePaewkd7UcNdeALzoHOkatnhs67f6sX3csHfu4IrOR80UnX
sk3gjZ/YsneibzzwlhtaW8oSfv2Ihnrb7d0Dfh0Hjug5vgZWw9It9SbgeiKu
ddWKvM0vOV5ufR4MvGA3+WuOc8cj8InDO506j13PG2xXG/93yKcvIeWT/Xjw
KcRpfVvHjpuaRGkD7RzmghmNW7XKbFyF44vIK1s7Z+pnhuSSfCJhpAUEBAQE
BAQEBAQEBAQEBAQEBAQEBDwzfAZVkHcWACgAAA==

--1678434306-347682473-1086209524=:1020--
