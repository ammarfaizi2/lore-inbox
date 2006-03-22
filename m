Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751263AbWCVOTQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263AbWCVOTQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 09:19:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751266AbWCVOTQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 09:19:16 -0500
Received: from mxsf04.cluster1.charter.net ([209.225.28.204]:10920 "EHLO
	mxsf04.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S1751263AbWCVOTQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 09:19:16 -0500
Message-ID: <44215CCB.1080005@cybsft.com>
Date: Wed, 22 Mar 2006 08:18:51 -0600
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rt1
References: <20060320085137.GA29554@elte.hu> <441F8017.4040302@cybsft.com> <20060321211653.GA3090@elte.hu> <4420B5F0.6000201@cybsft.com> <20060322062932.GA17166@elte.hu>
In-Reply-To: <20060322062932.GA17166@elte.hu>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * K.R. Foley <kr@cybsft.com> wrote:
> 
>> Sorry I have been onsite and completely buried today. Am running an 
>> initial test on both UP and SMP now with 2.6.16-rt1. UP doesn't look 
>> bad at all. SMP on the other hand doesn't look so good. I will give 
>> -rt4 a spin when these are done.
> 
> thanks for the testing - i'll check SMP too.
> 
> 	Ingo
> 
OK. On my dual 933 under heavy load I get the following with 2.6.16-rt4
and I get tons of missed interrupts. Running 2.6.15-rc16 I get a max of
88usec with most falling under 30usec. On my UP AthlonXP 1700 I get a
max of 19usec with 2.6.16-rt4 under load. What sort of results do you
see on SMP?

rtc latency histogram of {rtc_wakeup/7095, 17528666 samples}:
0 85
1 169
2 200
3 348
4 704
5 950
6 661
7 1123
8 1243
9 1217
10 1396
11 1932
12 1640
13 1136
14 839
15 9896
16 128030
17 653034
18 649117
19 980871
20 3100062
21 1568493
22 979036
23 811244
24 959543
25 732209
26 681492
27 856068
28 939870
29 649806
30 449958
31 367307
32 322118
33 238856
34 205575
35 184051
36 148624
37 147437
38 134690
39 126161
40 141023
41 192116
42 227147
43 199154
44 143090
45 101829
46 74295
47 55930
48 44070
49 35757
50 31143
51 28283
52 26081
53 24561
54 21771
55 20275
56 17621
57 14803
58 12567
59 10606
60 9132
61 8132
62 6978
63 5865
64 4751
65 4077
66 3367
67 3008
68 2718
69 2621
70 2504
71 2390
72 2071
73 1699
74 1430
75 1118
76 957
77 774
78 710
79 575
80 560
81 467
82 410
83 372
84 343
85 298
86 263
87 230
88 176
89 188
90 157
91 130
92 107
93 122
94 89
95 64
96 41
97 40
98 51
99 42
100 34
101 33
102 14
103 20
104 17
105 15
106 12
107 6
108 10
109 9
110 8
111 10
112 6
113 7
114 6
115 1
116 7
117 6
118 4
119 4
120 5
121 1
122 1
123 4
124 5
125 1
126 3
127 1
128 3
129 1
130 4
132 6
133 3
134 7
135 2
136 3
137 4
138 5
139 1
140 1
141 2
142 2
143 5
144 1
147 2
148 2
149 1
150 1
151 2
152 1
154 1
155 1
159 1
160 3
163 1
171 1
211 1
212 1
475 1
9187 1
9192 1
9219 1
9231 1
9259 1
9268 1


-- 
   kr
