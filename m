Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263323AbTC0R3b>; Thu, 27 Mar 2003 12:29:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263329AbTC0R3a>; Thu, 27 Mar 2003 12:29:30 -0500
Received: from geocentre.radio-msu.net ([194.67.80.110]:1920 "HELO
	oceanography.ru") by vger.kernel.org with SMTP id <S263323AbTC0R3X>;
	Thu, 27 Mar 2003 12:29:23 -0500
Message-ID: <3E8337CD.3090409@oceanography.ru>
Date: Thu, 27 Mar 2003 20:41:33 +0300
From: Jack <man@oceanography.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.20: hang on "ls -lR / >file"
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I do "# ls -lR / >/root/ls-lR"; and at some point (non-deterministic) my 
system locks up hard (e.g., sometimes software watchdog even detects lockup)
confirmed several times
once i did "# for i in /*; do ls -lR $i>>/root/ls-lR; done"; it 
succeded, when i did "#less /root/ls-lR" afterwards, it hung up again.
kernel 2.4.20 ; gcc-2.3.2; glibc-2.3.2; originally was slackware-8.0; 
athlon cpu on asus a7m266 mb
ibm 60gxp thru onboard via southbridge and maxtor 6y0l0 thru promise 
ultra66 add-on card (pdc-smth)


