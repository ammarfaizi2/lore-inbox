Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262780AbSJ1SJl>; Mon, 28 Oct 2002 13:09:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262810AbSJ1SJl>; Mon, 28 Oct 2002 13:09:41 -0500
Received: from stingr.net ([212.193.32.15]:13074 "EHLO hq.stingr.net")
	by vger.kernel.org with ESMTP id <S262780AbSJ1SJi>;
	Mon, 28 Oct 2002 13:09:38 -0500
Date: Mon, 28 Oct 2002 21:15:55 +0300
From: Paul P Komkoff Jr <i@stingr.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Somewhat broken in networking, 2.5.44{any suffix}
Message-ID: <20021028181555.GB17946@stingr.net>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Agent Darien Fawkes
X-Mailer: Intel Ultra ATA Storage Driver
X-RealName: Stingray Greatest Jr
Organization: Department of Fish & Wildlife
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just tried 2.5.44 plain, mm, ac, and 2.5.43

doing tracepath on 2.5.44-based kernels will stop at

sendto(3,
"\1\0\0\0\202}\275=\216j\4\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 65507,
0, {sin_family=AF_INET, sin_port=htons(44444),
sin_addr=inet_addr("194.87.0.50")}}, 16 <unfinished ...>

iputils is 020124 (actually 020124-r1 from gentoo but I think it
doesnt matter)

2.5.43 works fine here.

Any comments?

-- 
Paul P 'Stingray' Komkoff 'Greatest' Jr /// (icq)23200764 /// (http)stingr.net
  When you're invisible, the only one really watching you is you (my keychain)
