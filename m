Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262648AbSJ0VLh>; Sun, 27 Oct 2002 16:11:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262650AbSJ0VLh>; Sun, 27 Oct 2002 16:11:37 -0500
Received: from 205-158-62-133.outblaze.com ([205.158.62.133]:22166 "HELO
	ws5-2.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S262648AbSJ0VLh>; Sun, 27 Oct 2002 16:11:37 -0500
Message-ID: <20021027211751.1102.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-15"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>
To: linux-kernel@vger.kernel.org
Date: Mon, 28 Oct 2002 05:17:51 +0800
Subject: Re:[Benchmark] Chat results
X-Originating-Ip: 193.76.202.244
X-Originating-Server: ws5-3.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I changed the output of the results (thanks to jw schultz for the suggestions).

The benchmark repeast 10 times the following command:
./chat_c 127.0.0.1 30 1000 9999 

This means that:
o)it creates 30 chat rooms
o)it sends 1000 messages (the number of messages sent by each chat room member)

Then it evaluates the average throughput (messages per second).

Here the results:

Version		Throughput	Min	Max	Ratio
2.4.19		47250.9 	45634	50940	1.000
2.4.19-ck7	57210.1 	55007	61988	1.211
2.5.38		62543.3 	58416	64196	1.324
2.5.40		60115.4 	52443	63264	1.272
2.5.43		58807.5 	55376	60617	1.245
2.5.44		57906.2 	49808	60197	1.226
2.5.44-mm1	56060.7 	53250	58617	1.186
2.5.44-mm5	56778.8 	54685	59737	1.202

Comments ?

Paolo
-- 

Powered by Outblaze
