Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262675AbTIEOCN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 10:02:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262683AbTIEOCN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 10:02:13 -0400
Received: from maja.beep.pl ([195.245.198.10]:42254 "EHLO maja.beep.pl")
	by vger.kernel.org with ESMTP id S262675AbTIEOCK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 10:02:10 -0400
From: Arkadiusz Miskiewicz <arekm@pld-linux.org> (by way of Arkadiusz
	Miskiewicz <arekm@pld-linux.org>)
Organization: SelfOrganizing
Subject: Re: 2.6.0test4 bk1 and
Date: Fri, 5 Sep 2003 15:59:18 +0200
User-Agent: KMail/1.5.3
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200309051559.18910.arekm@pld-linux.org>
X-Authenticated-Id: arekm 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 25 of August 2003 15:35, Arkadiusz Miskiewicz wrote:
> Hi,
>
> Yesterday I've changed kernel from test3 to test4 with bk1 patch applied
> and such error appeared (and it's showning all the time):
>
> bad: scheduling while atomic!
> Call Trace:
>  [<c0105000>] _stext+0x0/0x60
>  [<c011ccd0>] schedule+0x3b0/0x3c0
>  [<cf8c1257>] acpi_processor_idle+0xe9/0x1e5 [processor]
>  [<c0105000>] _stext+0x0/0x60
>  [<c01090eb>] cpu_idle+0x3b/0x40
>  [<c0328734>] start_kernel+0x184/0x1b0
>  [<c0328480>] unknown_bootoption+0x0/0x100

Nothing about this has changed in test4bk3 nor test4bk6. Still yells about
,,scheduling while atomic''.

No one has idea what's happening here? Some change between test3 and test4
 did this.

--
Arkadiusz Mi¶kiewicz    CS at FoE, Wroclaw University of Technology
arekm.pld-linux.org AM2-6BONE, 1024/3DB19BBD, arekm(at)ircnet, PLD/Linux

