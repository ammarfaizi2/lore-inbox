Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265208AbSJaH0G>; Thu, 31 Oct 2002 02:26:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265209AbSJaH0F>; Thu, 31 Oct 2002 02:26:05 -0500
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:4622 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id <S265208AbSJaH0F>; Thu, 31 Oct 2002 02:26:05 -0500
Date: Thu, 31 Oct 2002 16:32:09 +0900 (JST)
Message-Id: <20021031.163209.595697847.yoshfuji@linux-ipv6.org>
To: pekkas@netcore.fi
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com, davem@redhat.com,
       kuznet@ms2.inr.ac.ru, usagi@linux-ipv6.org
Subject: Re: [PATCH] IPv6: Privacy Extensions for Stateless Address
 Autoconfiguration in IPv6
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <Pine.LNX.4.44.0210310908090.19356-100000@netcore.fi>
References: <20021031.124459.66300488.yoshfuji@linux-ipv6.org>
	<Pine.LNX.4.44.0210310908090.19356-100000@netcore.fi>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 90 22 65 EB 1E CF 3A D1 0B DF 80 D8 48 07 F8 94 E0 62 0E EA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: ,!^C1nUj;HDn\o}#MDnZW<|oj*]iIB/>/Rj|xZ=D=hBIY#)lQ,$n#kJvDg7at|p;w0^8&4_
 OS17ezZP7m/LlFJYPF}FdcGx!,qBM:w{Ub2#M8_@n^nYT%?u+bwTsqni(z5
X-Mailer: Mew version 2.2 on XEmacs 21.4.6 (Common Lisp)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.44.0210310908090.19356-100000@netcore.fi> (at Thu, 31 Oct 2002 09:25:01 +0200 (EET)), Pekka Savola <pekkas@netcore.fi> says:

> I belive privacy extensions can be harmful for especially long-lived
> applications and lead to a false sense of security: they should not be
> enabled (by any definition of enabled) by default.

Temporary addresses are generated (on most links) but not used by default 
(latter is done by source address selection) by my patch.  
Set sysctl net.ipv6.conf.ethXX.use_tempaddr > 1 to use it by default.

(I have per-application setsockopt interface but it is not included 
 because patch for source address selection is not accepted at this moment.)

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
