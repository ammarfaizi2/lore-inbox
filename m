Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313789AbSEMOP2>; Mon, 13 May 2002 10:15:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314056AbSEMOP1>; Mon, 13 May 2002 10:15:27 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:47115 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S313789AbSEMOPZ>; Mon, 13 May 2002 10:15:25 -0400
Message-Id: <200205131412.g4DECHY06608@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Steve Kieu <haiquy@yahoo.com>, kernel <linux-kernel@vger.kernel.org>
Subject: Re: OOPS 2.4.19-pre7-ac4 (Was: strange things in kernel 2.4.19-pre7-ac4 + preempt patch)
Date: Mon, 13 May 2002 17:14:57 -0200
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <20020513102825.35359.qmail@web10408.mail.yahoo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 May 2002 08:28, Steve Kieu wrote:
> > pointer got
> > corrupted and now movzbl stumbles over it.
> >
> > Bad RAM? Consider memtest86 run overnight.
> > --
>
> I did use memtest86 and all test is passed, no errors.
> And problem still persists with 2.4.19-pre8-ac2 ; oops
> after exiting X
>
> Now I have to use 2.4.16 ; any way all kernel before
> 2.4.19-pre2 is normal, I did not test 2.4.19-preX>2
> but 2.4.19-pre7-ac4 and 2.4.19-pre8-ac2

When no one answers on lkml to your oops report, you
have basically the only choice: start looking at stack trace
yourself, insert printks here and there, recompile and give it a try.

In other words, the source is with you. You *can* do it.
--
vda
