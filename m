Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264628AbSKCVuJ>; Sun, 3 Nov 2002 16:50:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264634AbSKCVuJ>; Sun, 3 Nov 2002 16:50:09 -0500
Received: from 205-158-62-131.outblaze.com ([205.158.62.131]:205 "HELO
	ws5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S264628AbSKCVuH>; Sun, 3 Nov 2002 16:50:07 -0500
Message-ID: <20021103215631.30007.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-15"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>
To: m.c.p@wolk-project.de
Date: Mon, 04 Nov 2002 05:56:31 +0800
Subject: Re: [ANNOUNCE] [PATCH] Linux-2.5.45-mcp3
X-Originating-Ip: 193.76.202.244
X-Originating-Server: ws5-1.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> P.S.: Con: want to benchmark this?

These are the results of contest 0.51 on my machine:

noload:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [3]              128.8   97      0       0       1.01
2.5.45 [1]              133.7   96      0       0       1.04
2.5.45-mcp3 [1]         134.0   96      0       0       1.05

process_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [3]              194.1   60      134     40      1.52
2.5.45 [1]              190.1   68      58      32      1.48
2.5.45-mcp3 [1]         190.4   68      59      33      1.49

io_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.45 [1]              396.9   37      36      10      3.10
2.5.45-mcp3 [1]         557.5   25      49      9       4.35

read_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.45 [1]              164.8   81      10      4       1.29
2.5.45-mcp3 [1]         169.7   78      10      4       1.33

list_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.45 [1]              151.1   87      0       6       1.18
2.5.45-mcp3 [1]         151.8   87      0       6       1.19

mem_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.19 [3]              161.1   80      38      2       1.26
2.5.44-mm5 [5]          200.2   66      34      1       1.56
2.5.45 [1]              188.9   70      35      1       1.47
2.5.45-mcp3 [1]         248.3   53      35      1       1.94

I hope it helps.

Ciao,
       Paolo

-- 

Powered by Outblaze
