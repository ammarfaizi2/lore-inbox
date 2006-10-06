Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751358AbWJFFeW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751358AbWJFFeW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 01:34:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751361AbWJFFeW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 01:34:22 -0400
Received: from wx-out-0506.google.com ([66.249.82.230]:12419 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751358AbWJFFeV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 01:34:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=qxX/A5xmF5Sl9Gq+haA5Fbi+RARjlazYKNMzR3vyfA7TNQ5HDgdgNa7W71pR5HzOY/c71AjvKKIiMT53L5DhE68zjrXJJE950BfTalGpJLvDy1i4jMxaEPrF5hQV6+6enRVyfsjobnxC1jNqf9C930g0Bpb+2ISjX+QaUCHUOJI=
Message-ID: <98975a8b0610052234p3287ab8fr70335f858ba4583b@mail.gmail.com>
Date: Fri, 6 Oct 2006 07:34:20 +0200
From: "=?ISO-8859-2?Q?Witold_W=B3adys=B3aw_Wojciech_Wilk?=" 
	<witold.wilk@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: how to get the kernel to be more "verbose"?
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I have a problem on my machine, it's the Asus A6M laptop (amd sempron
3200+, 2gb ram, 80gb disk, (still unknown sound card), realtek 8168
ethernet, broadcom wireless, geforce go6100 etc), using debian amd64
port stable.

I simply cannot compile a bootable kernel. Every single one hangs at a
single point:
NET: Registered protocol family 2

(I am writing from my memory).

It does not produce an oops, does not produce anything, just gets
stuck, no disk usage after this, simply the machine is totally
hang-up. Rebooting has to be done by the service reset button. The
power button doesn't even work.

I've tried differendt editions from 2.6.8 to the current. The 2.6.8 is
shipped with debian port to amd64 - and the default debian kernel
boots up. But I need the wi-fi broadcom card - that is quite new.

I've tried using the /proc/config.gz provided by the default kernel,
but to no avail.

The next step of loading the kernel I have seen in various logs is the
TCP/IP stack, am I right? I've tried mutiple types of networking
config (router, non router, with/without ipv6, etc). But it still
hangs up.

Always in the same place. There is no output even with all the
possible debugging options compiled in.

Can You in some extent point me where to look for errors, what could
it be? Is there any way of loading a kernel on top of the default
kernel, so when it crashes I can trace the problem somehow?

Also, I've tried both gcc 3.3 and 3.4.

Any help? Please point me at something, I am trying for two weeks
already, and I cannot find any problems like mine. Thanks a lot for
any help.
-- 
Witold Wladyslaw Wojciech Wilk Et39m:+48605066384 gg3211630 (lepiej @)
prr: giant boulder'02 @13kkm - brak czasu :( / tychy-sosnowiec-gliwice
pms: vw golf 2 byl, juz sprzedany :) / pierwszeimie.nazwisko@gmail.com
pms/kc: citroen xantia mkI 2.0 8v 1995 225kkm/17kkm hydrokomfortowa :)
