Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261916AbTJGNZz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 09:25:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262181AbTJGNZz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 09:25:55 -0400
Received: from dagobah.vivo.com.br ([200.244.85.31]:8611 "EHLO
	rjlngtw02.vivo.com.br") by vger.kernel.org with ESMTP
	id S261916AbTJGNZy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 09:25:54 -0400
Subject: Re:Re: SiI3112 DMA
To: andre@linux-ide.org
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OFF276FC3E.7B9257CB-ON03256DB8.0049184E@vivo.com.br>
From: juan.carlos@vivo.com.br
Date: Tue, 7 Oct 2003 11:25:37 -0200
X-MIMETrack: Serialize by Router on RJLNGTW02/Celular(Release 5.0.11  |July 24, 2002) at
 10/07/2003 10:25:52 AM
MIME-Version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Will we see a patch for 2.4.22-23 too? (Nudge nudge wink wink)

If this information is of any use for you, I was playing with a SiI 3112
yesterday (Abit mobo, Athlon XP2500 1800 MHz, Seagate 120MB 7200 RPM SATA
drive) and noticed that, while with 2.4.22-ac4 I had a hdparm -t result of
16 MB/sec, with 2.4.23-pre6 I got 25 MB/sec -- which is still less than the
32-33 MB/sec I get with normal ATA. Does that make any sense?

> It is an issue with first generation FIS transfer on the wire.
>
> Take the size of the request in sectors and divide by 15 or 7.5K.
Standard FIS packet size is 8K.
>
> Without going into much detail because of NDA's, there needs to be a
special DMA engine build table.
>
> I did it once then lost the code because of lack of sleep.

Juan Carlos Castro y Castro
VIVO - Diretoria de Processos de Negócio - Projetos
Tel.: 55 (21) 2574-3506 - Cel.: 55 (21) 9603-7440
juan.carlos@vivo.com.br
jcastro@vialink.com.br





