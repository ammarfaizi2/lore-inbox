Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267601AbUHEHnK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267601AbUHEHnK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 03:43:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267595AbUHEHnK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 03:43:10 -0400
Received: from main.gmane.org ([80.91.224.249]:9616 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S267593AbUHEHlo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 03:41:44 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Subject: Re: 3c59x very slow with 2.6.X
Date: Thu, 05 Aug 2004 09:41:40 +0200
Message-ID: <yw1xu0vit4jv.fsf@kth.se>
References: <200408042203.42367.bernd-schubert@web.de> <4111CD14.30601@bio.ifi.lmu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 161.80-203-29.nextgentel.com
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:9QVI9+hxYXygBa388hhiej8XcWk=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frank Steiner <fsteiner-mail@bio.ifi.lmu.de> writes:

> Bernd Schubert wrote:
>> Hello,
>> somehow the network speed is reduced to 14MBit with 2.6.X on my
>> system, with 2.4.X it has full 100MBit.
>> As all our systems boot diskless this is really annoying and I will
>> reboot 2.4.27 soon.
>> euklid:~# nttcp -T hamilton2
>>      Bytes  Real s   CPU s Real-MBit/s  CPU-MBit/s   Calls  Real-C/s   CPU-C/s
>> l  8388608    4.73    4.60     14.2004     14.5911    2048    433.36     445.3
>> 1  8388608    4.73    0.03     14.1984   2236.9621    6145   1300.12  204833.3
>
> No problem here: both machines have a 3com 3c905CX-TX and run kernel 2.6.7.
>
> zassenhaus /root# nttcp -T riemann
>       Bytes  Real s   CPU s Real-MBit/s  CPU-MBit/s   Calls  Real-C/s   CPU-C/s
> l  8388608    0.71    0.01     94.9903   7457.3690    2048   2898.87  227580.8
> 1  8388608    0.71    0.04     93.9984   1598.0964    5794   8115.57  137975.4
>
> The driver is compiled into the kernel, not as module. Could that make a
> difference for you?

FWIW, I'm using a 3c905C-TX with kernel 2.6.6 and 3c59x as a module,
without any problems at all.

-- 
Måns Rullgård
mru@kth.se

