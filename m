Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270818AbUJUUVe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270818AbUJUUVe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 16:21:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270910AbUJUUD6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 16:03:58 -0400
Received: from moutng.kundenserver.de ([212.227.126.184]:27339 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S270911AbUJUUBI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 16:01:08 -0400
From: Hans-Peter Jansen <hpj@urpla.net>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: ATA/133 Problems with multiple cards
Date: Thu, 21 Oct 2004 22:00:35 +0200
User-Agent: KMail/1.5.4
Cc: James Stevenson <james@stev.org>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org
References: <Pine.LNX.4.44.0410201211481.5805-100000@beast.stev.org> <200410201623.21321.hpj@urpla.net> <58cb370e041021114374bb749f@mail.gmail.com>
In-Reply-To: <58cb370e041021114374bb749f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410212200.35037.hpj@urpla.net>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:18d01dd0a2a377f0376b761557b5e99a
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 21 October 2004 20:43, Bartlomiej Zolnierkiewicz wrote:
> On Wed, 20 Oct 2004 16:23:21 +0200, Hans-Peter Jansen 
<hpj@urpla.net> wrote:
> > Hmm, I'm running 3 TX2/100 (even with different revisions)
> > without big problems here:
> >
> > 00:09.0 Unknown mass storage controller: Promise Technology, Inc.
> > 20268 (rev 02) 00:0a.0 Unknown mass storage controller: Promise
> > Technology, Inc. 20268 (rev 02) 00:0b.0 Unknown mass storage
> > controller: Promise Technology, Inc. 20268 (rev 01)
>
> lspci -xxx ?

With pleasure. Let me know, if I can provide anything else useful.
BTW, Bart, I suspect James' problem is, that his system is running in 
pic mode, while mine is in apic mode.

00:09.0 Unknown mass storage controller: Promise Technology, Inc. 
20268 (rev 02)
00: 5a 10 68 4d 07 00 30 04 02 85 80 01 08 40 00 00
10: 01 ec 00 00 01 e8 00 00 01 e4 00 00 01 e0 00 00
20: 01 dc 00 00 00 c0 ff df 00 00 00 00 5a 10 68 4d
30: 01 00 fe df 60 00 00 00 00 00 00 00 0a 01 04 12
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 01 00 21 02 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:0a.0 Unknown mass storage controller: Promise Technology, Inc. 
20268 (rev 02)
00: 5a 10 68 4d 07 00 30 04 02 85 80 01 08 40 00 00
10: 01 c4 00 00 01 c0 00 00 01 bc 00 00 01 b8 00 00
20: 01 b4 00 00 00 80 ff df 00 00 00 00 5a 10 68 4d
30: 01 00 fd df 60 00 00 00 00 00 00 00 09 01 04 12
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 01 00 21 02 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:0b.0 Unknown mass storage controller: Promise Technology, Inc. 
20268 (rev 01)
00: 5a 10 68 4d 07 00 30 04 01 85 80 01 08 40 00 00
10: 01 b0 00 00 01 ac 00 00 01 a8 00 00 01 a4 00 00
20: 01 a0 00 00 00 40 ff df 00 00 00 00 5a 10 68 4d
30: 01 00 fb df 60 00 00 00 00 00 00 00 05 01 04 12
40: 80 80 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 01 00 01 02 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00



> -
> To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

