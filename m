Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264454AbTGKRF6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 13:05:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264463AbTGKRF5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 13:05:57 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:9944 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S264454AbTGKRF4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 13:05:56 -0400
Date: Fri, 11 Jul 2003 14:18:10 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Henrique Oliveira <henrique2.gobbi@cyclades.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kevin Curtis <kevin.curtis@farsite.co.uk>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Why is generic hldc beig ignored?   RE:Linux 2.4.22-pre4
In-Reply-To: <013901c347cd$44586f60$602fa8c0@henrique>
Message-ID: <Pine.LNX.4.55L.0307111416100.29959@freak.distro.conectiva>
References: <7C078C66B7752B438B88E11E5E20E72E25C978@GENERAL.farsite.co.uk>
 <Pine.LNX.4.55L.0307101410570.25103@freak.distro.conectiva>
 <003101c34712$a9b8f480$602fa8c0@henrique> <1057914760.8028.27.camel@dhcp22.swansea.linux.org.uk>
 <013901c347cd$44586f60$602fa8c0@henrique>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 11 Jul 2003, Henrique Oliveira wrote:

> Hello !!!
> No offence here but the generic hdlc layer's been always confusing. I will
> write here what I believe is going on.
> Until version 2.4.20 we had the old hdlc layer, with only one source file
> hdlc.c. People that wanted to use the new hdlc layer had to apply a patch
> provided by Halasa or by the WAN cards vendors. The kernel 2.4.21 came out
> with the new hdlc layer, that includes a couple of files: hdlc_generic.c,
> hdlc_fr.c, hdlc_ppp.c, hdlc_raw.c, etc. I don't know the status of the -ac
> tree but I can say that the kernel 2.4.21 has the new code.
> The new hdlc layer really needs new tools. This new tool can (supposedly) be
> found at Halasa's web site. I don't know if someone has tested these tools
> but I am about to run a test this afternoon. If someone is interested on the
> results, just drop me a line.

I am.

Please report the results of your tests and CC lkml.

And Alan, what the -ac tree hdlc changes are about ?
