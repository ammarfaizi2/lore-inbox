Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265508AbSK1NeF>; Thu, 28 Nov 2002 08:34:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265513AbSK1NeE>; Thu, 28 Nov 2002 08:34:04 -0500
Received: from 205-158-62-68.outblaze.com ([205.158.62.68]:35340 "HELO
	spf0.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S265508AbSK1NeE>; Thu, 28 Nov 2002 08:34:04 -0500
Message-ID: <20021128134118.27580.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>
To: davidsen@tmr.com
Cc: linux-kernel@vger.kernel.org
Date: Thu, 28 Nov 2002 21:41:18 +0800
Subject: Re: [Benchmark] AIM9 results
X-Originating-Ip: 194.185.48.246
X-Originating-Server: ws5-3.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bill Davidsen <davidsen@tmr.com>

> > stream_pipe 10000 2807.4       280740.00 Stream Pipe Messages/second
> > stream_pipe 10000 2602.3       260230.00 Stream Pipe Messages/second
> > stream_pipe 10000 2487.1       248710.00 Stream Pipe Messages/second
> > 
> > dgram_pipe 10000 2756.9       275690.00 DataGram Pipe Messages/second
> > dgram_pipe 10000 2460.5       246050.00 DataGram Pipe Messages/second
> > dgram_pipe 10000 2377.9       237790.00 DataGram Pipe Messages/second
> > 
> > pipe_cpy 10000 4164.8       416480.00 Pipe Messages/second
> > pipe_cpy 10000 3736.4       373640.00 Pipe Messages/second
> > pipe_cpy 10000 3670.4       367040.00 Pipe Messages/second
> > 
> > ram_copy 10000 23801.6    595516032.00 Memory to Memory Copy/second
> > ram_copy 10000 23583    590046660.00 Memory to Memory Copy/second
> > ram_copy 10000 23578    589921560.00 Memory to Memory Copy/second
> 
> You didn't comment on these, but it clearly looks as if all methods of IPC
> are getting slower, even shared memory. This has been discussed
> previously, some of it has known areas of improvement, so I'm surprised
> that the -mm kernel was slower.

Yep, you are rigth. Didn't notice it. And really don't know
why -mm is still slower than 2.4.19 in these tests.

Paolo

-- 
______________________________________________
http://www.linuxmail.org/
Now with POP3/IMAP access for only US$19.95/yr

Powered by Outblaze
