Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310558AbSCGXNU>; Thu, 7 Mar 2002 18:13:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310585AbSCGXNN>; Thu, 7 Mar 2002 18:13:13 -0500
Received: from exchange.macrolink.com ([64.173.88.99]:45831 "EHLO
	exchange.macrolink.com") by vger.kernel.org with ESMTP
	id <S293507AbSCGXM4>; Thu, 7 Mar 2002 18:12:56 -0500
Message-ID: <11E89240C407D311958800A0C9ACF7D13A76E4@EXCHANGE>
From: Ed Vance <EdV@macrolink.com>
To: "'Bill Nottingham'" <notting@redhat.com>
Cc: "'linux-serial'" <linux-serial@vger.kernel.org>,
        "'linux-kernel'" <linux-kernel@vger.kernel.org>,
        "'Russell King'" <rmk@arm.linux.org.uk>,
        "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>
Subject: RE: [PATCH] serial.c procfs kudzu - discussion
Date: Thu, 7 Mar 2002 15:12:54 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C1C62D.9C9F0620"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C1C62D.9C9F0620
Content-Type: text/plain;
	charset="iso-8859-1"

Bill Nottingham wrote:
> Ed Vance (EdV@macrolink.com) said: 
> > 4. Should a bug be turned in against kudzu for the weak parser? 
> 
>Absolutely. When did the serial change go in?

Hi Bill,

This is not the result of a recent change to the serial driver. I don't 
know how far back this bug goes, but I suspect it is as old as the proc 
fs serial support. 

The recent event was me adding memory mapped support for a couple of 
CompactPCI serial mux cards. Apparently everyone else on the planet 
uses I/O space (or just did not report it) and the driver/kudzu 
combination works fine with serial cards in I/O space. 

Do you want me to go ahead and put it into bugzilla? 

BTW, I have attached the procfs data produced with and without the 
driver bug.

Best regards,
Ed Vance

---------------------------------------------------------------- 
Ed Vance              edv@macrolink.com
Macrolink, Inc.       1500 N. Kellogg Dr  Anaheim, CA  92807
----------------------------------------------------------------



------_=_NextPart_000_01C1C62D.9C9F0620
Content-Type: application/octet-stream;
	name="bad_proc_serial"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="bad_proc_serial"

serinfo:1.0 driver:5.05c revision:2001-07-08=0A=
0: uart:16550A port:3F8 irq:4 tx:0 rx:0 RTS|DTR=0A=
1: uart:16550A port:2F8 irq:3 tx:0 rx:0 =0A=
2: uart:unknown port:3E8 irq:4=0A=
3: uart:unknown port:2E8 irq:3=0A=
4: uart:16C950/954 port:0 irq:14=0A=
5: uart:16C950/954 port:0 irq:14=0A=
6: uart:16C950/954 port:0 irq:14=0A=
7: uart:16C950/954 port:0 irq:14=0A=
8: uart:16C950/954 port:0 irq:14=0A=
9: uart:16C950/954 port:0 irq:14=0A=
10: uart:16C950/954 port:0 irq:14=0A=
11: uart:16C950/954 port:0 irq:14=0A=
12: uart:16C950/954 port:0 irq:14=0A=
13: uart:16C950/954 port:0 irq:14=0A=
14: uart:16C950/954 port:0 irq:14=0A=
15: uart:16C950/954 port:0 irq:14=0A=
16: uart:16C950/954 port:0 irq:14=0A=
17: uart:16C950/954 port:0 irq:14=0A=
18: uart:16C950/954 port:0 irq:14=0A=
19: uart:16C950/954 port:0 irq:14=0A=
20: uart:ST16654 port:0 irq:10=0A=
21: uart:ST16654 port:0 irq:10=0A=
22: uart:ST16654 port:0 irq:10=0A=
23: uart:ST16654 port:0 irq:10=0A=
24: uart:ST16654 port:0 irq:10=0A=
25: uart:ST16654 port:0 irq:10=0A=
26: uart:ST16654 port:0 irq:10=0A=
27: uart:ST16654 port:0 irq:10=0A=
28: uart:ST16654 port:0 irq:10=0A=
29: uart:ST16654 port:0 irq:10=0A=
30: uart:ST16654 port:0 irq:10=0A=
31: uart:ST16654 port:0 irq:10=0A=
32: uart:ST16654 port:0 irq:10=0A=
33: uart:ST16654 port:0 irq:10=0A=
34: uart:ST16654 port:0 irq:10=0A=
35: uart:ST16654 port:0 irq:10=0A=
36: uart:unknown port:302 irq:3=0A=
37: uart:unknown port:302 irq:3=0A=
38: uart:unknown port:302 irq:3=0A=
39: uart:unknown port:302 irq:3=0A=
40: uart:unknown port:302 irq:3=0A=
41: uart:unknown port:302 irq:3=0A=
42: uart:unknown port:302 irq:3=0A=
43: uart:unknown port:302 irq:3=0A=
44: uart:unknown port:0 irq:0=0A=
45: uart:unknown port:0 irq:0=0A=
46: uart:unknown port:0 irq:0=0A=
47: uart:unknown port:0 irq:0=0A=
48: uart:unknown port:0 irq:0=0A=
49: uart:unknown port:0 irq:0=0A=
50: uart:unknown port:0 irq:0=0A=
51: uart:unknown port:0 irq:0=0A=
52: uart:unknown port:0 irq:0=0A=
53: uart:unknown port:0 irq:0=0A=
54: uart:unknown port:0 irq:0=0A=
55: uart:unknown port:0 irq:0=0A=
56: uart:unknown port:0 irq:0=0A=
57: uart:unknown port:0 irq:0=0A=
58: uart:unknown port:0 irq:0=0A=
59: uart:unknown port:0 irq:0=0A=
60: uart:unknown port:0 irq:0=0A=
61: uart:unknown port:0 irq:0=0A=
62: uart:unknown port:0 irq:0=0A=
63: uart:unknown port:0 irq:0=0A=

------_=_NextPart_000_01C1C62D.9C9F0620
Content-Type: application/octet-stream;
	name="good_proc_serial"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="good_proc_serial"

serinfo:1.0 driver:5.05c-mlA3 revision:2001-11-27=0A=
0: uart:16550A port:3F8 irq:4 baud:9600 tx:11 rx:0 =0A=
1: uart:16550A port:2F8 irq:3 baud:9600 tx:11 rx:26 =0A=
2: uart:unknown port:3E8 irq:4 =0A=
3: uart:unknown port:2E8 irq:3 =0A=
4: uart:16C950/954 port:C4800000 irq:14 tx:0 rx:0 =0A=
5: uart:16C950/954 port:C4802020 irq:14 tx:0 rx:0 =0A=
6: uart:16C950/954 port:C4804040 irq:14 tx:0 rx:0 =0A=
7: uart:16C950/954 port:C4806060 irq:14 tx:0 rx:0 =0A=
8: uart:16C950/954 port:C4808000 irq:14 tx:0 rx:0 =0A=
9: uart:16C950/954 port:C480A020 irq:14 tx:0 rx:0 =0A=
10: uart:16C950/954 port:C480C040 irq:14 tx:0 rx:0 =0A=
11: uart:16C950/954 port:C480E060 irq:14 tx:0 rx:0 =0A=
12: uart:16C950/954 port:C4810400 irq:14 tx:0 rx:0 =0A=
13: uart:16C950/954 port:C4812420 irq:14 tx:0 rx:0 =0A=
14: uart:16C950/954 port:C4814440 irq:14 tx:0 rx:0 =0A=
15: uart:16C950/954 port:C4816460 irq:14 tx:0 rx:0 =0A=
16: uart:16C950/954 port:C4818800 irq:14 tx:0 rx:0 =0A=
17: uart:16C950/954 port:C481A820 irq:14 tx:0 rx:0 =0A=
18: uart:16C950/954 port:C481C840 irq:14 tx:0 rx:0 =0A=
19: uart:16C950/954 port:C481E860 irq:14 tx:0 rx:0 =0A=
20: uart:ST16654 port:C4820000 irq:10 tx:0 rx:0 =0A=
21: uart:ST16654 port:C4822008 irq:10 tx:0 rx:0 =0A=
22: uart:ST16654 port:C4824010 irq:10 tx:0 rx:0 =0A=
23: uart:ST16654 port:C4826018 irq:10 tx:0 rx:0 =0A=
24: uart:ST16654 port:C4828020 irq:10 tx:0 rx:0 =0A=
25: uart:ST16654 port:C482A028 irq:10 tx:0 rx:0 =0A=
26: uart:ST16654 port:C482C030 irq:10 tx:0 rx:0 =0A=
27: uart:ST16654 port:C482E038 irq:10 tx:0 rx:0 =0A=
28: uart:ST16654 port:C4830040 irq:10 tx:0 rx:0 =0A=
29: uart:ST16654 port:C4832048 irq:10 tx:0 rx:0 =0A=
30: uart:ST16654 port:C4834050 irq:10 tx:0 rx:0 =0A=
31: uart:ST16654 port:C4836058 irq:10 tx:0 rx:0 =0A=
32: uart:ST16654 port:C4838060 irq:10 tx:0 rx:0 CD=0A=
33: uart:ST16654 port:C483A068 irq:10 tx:0 rx:0 CD=0A=
34: uart:ST16654 port:C483C070 irq:10 tx:0 rx:0 CD=0A=
35: uart:ST16654 port:C483E078 irq:10 tx:0 rx:0 CD=0A=
36: uart:unknown port:0 irq:0 =0A=
37: uart:unknown port:0 irq:0 =0A=
38: uart:unknown port:0 irq:0 =0A=
39: uart:unknown port:0 irq:0 =0A=
40: uart:unknown port:0 irq:0 =0A=
41: uart:unknown port:0 irq:0 =0A=
42: uart:unknown port:0 irq:0 =0A=
43: uart:unknown port:0 irq:0 =0A=
44: uart:unknown port:0 irq:0 =0A=
45: uart:unknown port:0 irq:0 =0A=
46: uart:unknown port:0 irq:0 =0A=
47: uart:unknown port:0 irq:0 =0A=
48: uart:unknown port:0 irq:0 =0A=
49: uart:unknown port:0 irq:0 =0A=
50: uart:unknown port:0 irq:0 =0A=
51: uart:unknown port:0 irq:0 =0A=
52: uart:unknown port:0 irq:0 =0A=
53: uart:unknown port:0 irq:0 =0A=
54: uart:unknown port:0 irq:0 =0A=
55: uart:unknown port:0 irq:0 =0A=
56: uart:unknown port:0 irq:0 =0A=
57: uart:unknown port:0 irq:0 =0A=
58: uart:unknown port:0 irq:0 =0A=
59: uart:unknown port:0 irq:0 =0A=
60: uart:unknown port:0 irq:0 =0A=
61: uart:unknown port:0 irq:0 =0A=
62: uart:unknown port:0 irq:0 =0A=
63: uart:unknown port:0 irq:0 =0A=

------_=_NextPart_000_01C1C62D.9C9F0620--
