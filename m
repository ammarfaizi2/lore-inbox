Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317704AbSGPBqM>; Mon, 15 Jul 2002 21:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317706AbSGPBqL>; Mon, 15 Jul 2002 21:46:11 -0400
Received: from smtp-outbound.cwctv.net ([213.104.18.10]:30262 "EHLO
	smtp.cwctv.net") by vger.kernel.org with ESMTP id <S317704AbSGPBqK>;
	Mon, 15 Jul 2002 21:46:10 -0400
From: <Hell.Surfers@cwctv.net>
To: zhengcb@netpower.com.cn, linux-kernel@vger.kernel.org
Date: Tue, 16 Jul 2002 02:48:35 +0100
Subject: RE:Re: Re: how to improve the throughput of linux network
MIME-Version: 1.0
X-Mailer: Liberate TVMail 2.6
Content-Type: multipart/mixed;
 boundary="1026784115490"
Message-ID: <0f9412748011072DTVMAIL3@smtp.cwctv.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1026784115490
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Using it as a module would only slow you down if netfilter is required, because itwould load and unload, contstantly, causing you to remember what the 486 was like.

- "Yes. Yes. OKAY.", Installing Microsoft software has always felt like an argument with your Mum (alledgedly).

On 	Tue, 16 Jul 2002 9:23:45 +0800 	zhengchuanbo <zhengcb@netpower.com.cn> wrote:

--1026784115490
Content-Type: message/rfc822
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Received: from vger.kernel.org ([209.116.70.75]) by smtp.cwctv.net  with Microsoft SMTPSVC(5.5.1877.447.44);
	 Tue, 16 Jul 2002 02:22:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317729AbSGPBSh>; Mon, 15 Jul 2002 21:18:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317728AbSGPBSg>; Mon, 15 Jul 2002 21:18:36 -0400
Received: from [210.78.134.243] ([210.78.134.243]:42513 "EHLO 210.78.134.243")
	by vger.kernel.org with ESMTP id <S317726AbSGPBSg>;
	Mon, 15 Jul 2002 21:18:36 -0400
Received: from zhengcb [218.30.30.2] by 210.78.134.243 with ESMTP
  (SMTPD32-7.07) id A626BB0128; Tue, 16 Jul 2002 09:25:58 +0800
Date: Tue, 16 Jul 2002 9:23:45 +0800
From: zhengchuanbo <zhengcb@netpower.com.cn>
To: Mark Hahn <hahn@physics.mcmaster.ca>
CC: linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>
Subject: Re: Re: how to improve the throughput of linux network
X-mailer: FoxMail 3.11 Release [cn]
Mime-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 7bit
Message-Id: <200207160926819.SM00792@zhengcb>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Return-Path: linux-kernel-owner+hell.surfers=40cwctv.net@vger.kernel.org


>> we use linux as our router. i just tested the performance of the router with smartbits, and i found that the throughput of 64byte frame is only 25%, about 35kpps. 
>> someone mentioned that the throughput of 64byte frame could reach 70kpps.so i wish i could improve the performance of our router,but i don't know how to do that.

>you will probably need to provide a lot more details,
>such as what the host CPU is, whether you've done any
>kernel profiling, which kernel you're using, etc.

the CPU is PIII800, 256M ram. 
kernel 2.4.19-pre1
i just add some patches of netfilter to the kernel,such as the time patch. btw,i compiled all the netfilter options into the kernel,not as modules. will that affect the performance?
thanks.

chuanbo zheng


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
--1026784115490--


