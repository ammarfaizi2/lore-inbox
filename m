Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264732AbTGCPvq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 11:51:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264432AbTGCPt7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 11:49:59 -0400
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:16400 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id S264694AbTGCPtJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 11:49:09 -0400
Date: Fri, 04 Jul 2003 01:04:54 +0900 (JST)
Message-Id: <20030704.010454.101761988.yoshfuji@linux-ipv6.org>
To: liiwi@lonesom.pp.fi
Cc: linux-kernel@vger.kernel.org
Subject: Re: netstat oopses 2.5.74
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <87n0fv7gio.fsf@jumper.lonesom.pp.fi>
References: <87n0fv7gio.fsf@jumper.lonesom.pp.fi>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 90 22 65 EB 1E CF 3A D1 0B DF 80 D8 48 07 F8 94 E0 62 0E EA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

In article <87n0fv7gio.fsf@jumper.lonesom.pp.fi> (at Thu, 03 Jul 2003 18:54:07 +0300), Jaakko Niemi <liiwi@lonesom.pp.fi> says:

>  I can reproduce attached oops by running 'netstat -na' after 
>  logging in. Changing compiler from gcc 3.3 to 2.95 does not
>  seem to change things. Please cc me on replies. 

Please apply this patch:
http://bugme.osdl.org/attachment.cgi?id=476&action=view

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
