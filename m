Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267730AbSLTCTa>; Thu, 19 Dec 2002 21:19:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267736AbSLTCTa>; Thu, 19 Dec 2002 21:19:30 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:26111 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S267730AbSLTCT1>;
	Thu, 19 Dec 2002 21:19:27 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15874.32773.829438.109509@napali.hpl.hp.com>
Date: Thu, 19 Dec 2002 18:27:17 -0800
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Grant Grundler <grundler@cup.hp.com>, mj@ucw.cz,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       turukawa@icc.melco.co.jp
Subject: Re: PATCH 2.5.x disable BAR when sizing
In-Reply-To: <1040352868.30778.12.camel@irongate.swansea.linux.org.uk>
References: <20021219213712.0518B12CB2@debian.cup.hp.com>
	<1040352868.30778.12.camel@irongate.swansea.linux.org.uk>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On 20 Dec 2002 02:54:28 +0000, Alan Cox <alan@lxorguk.ukuu.org.uk> said:

  Alan> On Thu, 2002-12-19 at 21:37, Grant Grundler wrote:
  >>  Martin, In April 2002, turukawa@icc.melco.co.jp sent a 2.4.x
  >> patch to disable BARs while the BARs were being sized.  I've
  >> "forward ported" this patch to 2.5.x (appended).  turukawa's
  >> excellent problem description and original posting are here:
  >> https://lists.linuxia64.org/archives//linux-ia64/2002-April/003302.html
  >>
  >> David Mosberger agrees this is an "obvious fix".  We've been
  >> using this in the ia64 2.4 code stream since about August.

  Alan> We've rejected this twice already from different people.

  Alan> Nothing says your memory can't be behind the bridge and you
  Alan> just turned memory access off. Whoops bang, game over.

  Alan> And yes this happens on some PC class systems.

And yet it's OK to remap that memory?  That seems unlikely.

	--david
