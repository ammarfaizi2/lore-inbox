Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264919AbSL0NFG>; Fri, 27 Dec 2002 08:05:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264925AbSL0NFG>; Fri, 27 Dec 2002 08:05:06 -0500
Received: from 205-158-62-139.outblaze.com ([205.158.62.139]:10883 "HELO
	spf1.us.outblaze.com") by vger.kernel.org with SMTP
	id <S264919AbSL0NFF>; Fri, 27 Dec 2002 08:05:05 -0500
Message-ID: <20021227131313.29241.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>
To: conman@kolivas.net, linux-kernel@vger.kernel.org
Cc: ciarrocchi@linuxmail.org, akpm@digeo.com
Date: Fri, 27 Dec 2002 21:13:13 +0800
Subject: Re: [BENCHMARK] vm swappiness with contest
X-Originating-Ip: 193.76.202.244
X-Originating-Server: ws5-1.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Con Kolivas <conman@kolivas.net>
[...]
> Paolo if I was to choose a number from these values I'd suggest lower than 60 
> rather than higher, BUT that is because the io load effects become a real 
> problem when the kernel is swappy - don't _really_ know what this means for 
> the rest of the time. Maybe in the 40-50 range. There seems to be a knee 
> (bend) in the curve (most noticable in dbench_load) rather than the curves 
> being linear. That knee I believe simply shows the way the algorithm for 
> swappiness basically works. I might throw a 50 at the machine as well to see 
> what that does.

Con, thank you for your time and results.
I have to confirm you that large file writes with a swappy kernel 
seems to waste time swapping data, I see it with the resp tool too.

May be we can say that a good value for a desktop enviroment is in the
40-50 range while for a server is 70-80, this because with the osdb bench
tool I get the best results with 80.

Ciao,
        Paolo 
-- 
______________________________________________
http://www.linuxmail.org/
Now with POP3/IMAP access for only US$19.95/yr

Powered by Outblaze
