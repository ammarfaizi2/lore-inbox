Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269259AbTCBSI5>; Sun, 2 Mar 2003 13:08:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269262AbTCBSI5>; Sun, 2 Mar 2003 13:08:57 -0500
Received: from 205-158-62-139.outblaze.com ([205.158.62.139]:27864 "HELO
	spf1.us.outblaze.com") by vger.kernel.org with SMTP
	id <S269259AbTCBSIz>; Sun, 2 Mar 2003 13:08:55 -0500
Message-ID: <20030302181914.28851.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>
To: linux-kernel@vger.kernel.org
Cc: akpm@digeo.com
Date: Mon, 03 Mar 2003 02:19:14 +0800
Subject: [BENCHMARK] chat results
X-Originating-Ip: 193.76.202.244
X-Originating-Server: ws5-1.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
has been a long time since the last time I posted the results of the chat benchmark.

Something strange happens in 2.5.63*
10 runs for each kernel
Version		Throughput	Min	Max	Ratio
2.4.19-ck7	57210.1 	55007	61988	1.000
2.4.19		47250.9 	45634	50940	0.826
2.5.38		62543.3 	58416	64196	1.093
2.5.40		60115.4 	52443	63264	1.051
2.5.43		58807.5 	55376	60617	1.028
2.5.44-mm1	56060.7 	53250	58617	0.980
2.5.44-mm5	56778.8 	54685	59737	0.992
2.5.44-mm6	57106 		53157	59385	0.998
2.5.44		57906.2 	49808	60197	1.012
2.5.45		56822.7 	55267	59651	0.993
2.5.46		57106.9 	54388	59432	0.998
2.5.49		56188.8 	53938	57825	0.982
2.5.50		53191 		26636	58603	0.930
2.5.53		55815.7 	53807	58414	0.976
2.5.54bk4	56988.5 	55644	58530	0.996
2.5.59		56962.8 	54391	58416	0.996
2.5.60-cfq2	55966.8 	54391	57546	0.978
2.5.61		55592 		53932	57043	0.972
2.5.63-mjb2	54064.7 	27396	59334	0.945
2.5.63		54304.2 	27175	59169	0.949

-- 2.5.63 -- 
Average throughput : 58682 messages per second
Average throughput : 56287 messages per second
Average throughput : 56127 messages per second
Average throughput : 27175 messages per second
Average throughput : 57696 messages per second
Average throughput : 57918 messages per second
Average throughput : 57793 messages per second
Average throughput : 56328 messages per second
Average throughput : 55867 messages per second
Average throughput : 59169 messages per second

-- 2.5.63-mjb2 --
Average throughput : 59334 messages per second
Average throughput : 57104 messages per second
Average throughput : 54823 messages per second
Average throughput : 55014 messages per second
Average throughput : 59313 messages per second
Average throughput : 58056 messages per second
Average throughput : 57461 messages per second
Average throughput : 55884 messages per second
Average throughput : 27396 messages per second
Average throughput : 56262 messages per second

I still don't know why 2.5.38 is the winner...

Ciao,
           Paolo

-- 
______________________________________________
http://www.linuxmail.org/
Now with e-mail forwarding for only US$5.95/yr

Powered by Outblaze
