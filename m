Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317312AbSIMHCi>; Fri, 13 Sep 2002 03:02:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318538AbSIMHCh>; Fri, 13 Sep 2002 03:02:37 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:8714 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S317312AbSIMHCh>; Fri, 13 Sep 2002 03:02:37 -0400
Message-Id: <200209130702.g8D72sp09062@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Jan Kasprzak <kas@informatics.muni.cz>, kernel@street-vision.com
Subject: Re: AMD 760MPX DMA lockup (partly solved)
Date: Fri, 13 Sep 2002 09:58:00 -0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
References: <20020912161258.A9056@fi.muni.cz> <200209121815.g8CIFdp06612@Port.imtp.ilyichevsk.odessa.ua> <20020912211452.C29717@fi.muni.cz>
In-Reply-To: <20020912211452.C29717@fi.muni.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 September 2002 17:14, Jan Kasprzak wrote:
> : This is 2.4.20-pre1, dual AMD 2000MP, only difference is it is the Tyan
> : version of the MPX, not the MSI.
> :
> : Justin
>
>         Justin, thanks for this! I've tried 2.4.20-pre1 with your
> .config (and then with my .config), and it works!
>
>         Further investigation showed that the problem first appeared
> somewhere between 2.4.20-pre2 (works for me) and 2.4.20-pre5 (has the
> lock-up problem I've described). I was not able to test -pre3 and -pre4,
> because these kernel died on me during boot after the
> "Initializing RT netlink socket" message.

It would be interesting to test 2.4.20-pre5 on Justin's box
(if he can risk fs damage)
--
vda
