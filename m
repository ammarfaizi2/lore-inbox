Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265884AbUFDQDZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265884AbUFDQDZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 12:03:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265857AbUFDPyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 11:54:47 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:24079 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S265855AbUFDPyA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 11:54:00 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Thomas Zehetbauer <thomasz@hostmaster.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.7-rc2
Date: Fri, 4 Jun 2004 17:06:27 +0300
User-Agent: KMail/1.5.4
References: <Pine.LNX.4.58.0405292349110.1632@ppc970.osdl.org> <1086187044.6179.8.camel@hostmaster.org>
In-Reply-To: <1086187044.6179.8.camel@hostmaster.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406041706.27716.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 June 2004 17:37, Thomas Zehetbauer wrote:
> http://bugzilla.kernel.org/show_bug.cgi?id=2819
>
> Make oldconfig silently disabled support for my CONFIG_TIGON3 NIC.
>
> It seems that it depends on CONFIG_NET_GIGE which in turn depends on
> CONFIG_NET_ETHERNET which was not required in 2.6.6 kernel.
>
> Tom

Many days ago I read on lkml that separating 10,100 and 1000 Mbit
ethernet is not really justified. There are devices which have
100 and 1000 variants.

Just keeping all ethernet devices in one menu sounds sane to me.
--
vda

