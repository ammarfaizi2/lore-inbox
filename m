Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261507AbULTNAJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261507AbULTNAJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 08:00:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261508AbULTNAI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 08:00:08 -0500
Received: from pne-smtpout2-sn1.fre.skanova.net ([81.228.11.159]:44257 "EHLO
	pne-smtpout2-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S261507AbULTNAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 08:00:05 -0500
Message-ID: <1348970.1103547593171.JavaMail.tomcat@pne-ps1-sn1>
Date: Mon, 20 Dec 2004 13:59:53 +0100 (MET)
From: Voluspa <lista4@comhem.se>
Reply-To: lista4@comhem.se
To: kernel@kolivas.org
Subject: Re: 2.6.10-rc3: kswapd eats CPU on start of memory-eating task
Cc: nickpiggin@yahoo.com.au, akpm@osdl.org, linux-kernel@vger.kernel.org,
       mr@ramendik.ru, riel@redhat.com
Mime-Version: 1.0
Content-Type: text/plain;charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Mailer: CP Presentation Server
X-clientstamp: [213.64.150.229]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
>> Logistically what makes sense is if a timeout of 0 is used as a test 
>> that completely disables it (avoids another sysctl too). In time for 
>> 2.6.10 we should disable it by default until the regressions are better 
>> understood. Tuning it into a useful "on" position can happen later and 
I 
>> suspect requires more code.
>
>This patch should have the desired effect.

Yes, it sure has. And with that I mean, YES. My testcase shows no freezes now, 
and it has the same swapping time as 2.6.8.1-bk2.

Thanks Con,
Mats Johannesson

