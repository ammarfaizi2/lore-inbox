Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267556AbUHEGBJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267556AbUHEGBJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 02:01:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267562AbUHEGBJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 02:01:09 -0400
Received: from acheron.informatik.uni-muenchen.de ([129.187.214.135]:58757
	"EHLO acheron.informatik.uni-muenchen.de") by vger.kernel.org
	with ESMTP id S267556AbUHEGAy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 02:00:54 -0400
Message-ID: <4111CD14.30601@bio.ifi.lmu.de>
Date: Thu, 05 Aug 2004 08:00:52 +0200
From: Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040503)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bernd Schubert <bernd-schubert@web.de>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 3c59x very slow with 2.6.X
References: <200408042203.42367.bernd-schubert@web.de>
In-Reply-To: <200408042203.42367.bernd-schubert@web.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernd Schubert wrote:
> Hello,
> 
> somehow the network speed is reduced to 14MBit with 2.6.X on my system, with 
> 2.4.X it has full 100MBit.
> As all our systems boot diskless this is really annoying and I will reboot 
> 2.4.27 soon.
> 
> euklid:~# nttcp -T hamilton2
>      Bytes  Real s   CPU s Real-MBit/s  CPU-MBit/s   Calls  Real-C/s   CPU-C/s
> l  8388608    4.73    4.60     14.2004     14.5911    2048    433.36     445.3
> 1  8388608    4.73    0.03     14.1984   2236.9621    6145   1300.12  204833.3


No problem here: both machines have a 3com 3c905CX-TX and run kernel 2.6.7.

zassenhaus /root# nttcp -T riemann
      Bytes  Real s   CPU s Real-MBit/s  CPU-MBit/s   Calls  Real-C/s   CPU-C/s
l  8388608    0.71    0.01     94.9903   7457.3690    2048   2898.87  227580.8
1  8388608    0.71    0.04     93.9984   1598.0964    5794   8115.57  137975.4

The driver is compiled into the kernel, not as module. Could that make a
difference for you?

cu,
Frank

-- 
Dipl.-Inform. Frank Steiner   Web:  http://www.bio.ifi.lmu.de/~steiner/
Lehrstuhl f. Bioinformatik    Mail: http://www.bio.ifi.lmu.de/~steiner/m/
LMU, Amalienstr. 17           Phone: +49 89 2180-4049
80333 Muenchen, Germany       Fax:   +49 89 2180-99-4049
* Rekursion kann man erst verstehen, wenn man Rekursion verstanden hat. *
