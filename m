Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263551AbUDZVBv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263551AbUDZVBv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 17:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263564AbUDZVBv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 17:01:51 -0400
Received: from mail.tpgi.com.au ([203.12.160.61]:4241 "EHLO mail4.tpgi.com.au")
	by vger.kernel.org with ESMTP id S263551AbUDZVBt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 17:01:49 -0400
Date: Tue, 27 Apr 2004 06:39:55 +1000
From: "Nigel Cunningham" <ncunningham@linuxmail.com>
To: "Pavel Machek" <pavel@ucw.cz>
Subject: Re: Bug#234976: kernel-source-2.6.4: Software Suspend doesn't work
Cc: "Herbert Xu" <herbert@gondor.apana.org.au>, 234976@bugs.debian.org,
       "Roland Stigge" <stigge@antcom.de>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Reply-To: ncunningham@linuxmail.com
References: <1080315725.2951.10.camel@atari.stigge.org> <20040326155315.GD291@elf.ucw.cz> <1080317555.12244.5.camel@atari.stigge.org> <20040326161717.GE291@elf.ucw.cz> <1080325072.2112.89.camel@atari.stigge.org> <20040426094834.GA4901@gondor.apana.org.au> <20040426104015.GA5772@gondor.apana.org.au> <opr6193np1ruvnp2@laptop-linux.wpcb.org.au> <20040426121145.GA7610@gondor.apana.org.au> <opr62cbzp9ruvnp2@laptop-linux.wpcb.org.au> <20040426134636.GB6285@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain; format=flowed; delsp=yes; charset=us-ascii
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <opr62zotwfruvnp2@laptop-linux.wpcb.org.au>
In-Reply-To: <20040426134636.GB6285@atrey.karlin.mff.cuni.cz>
User-Agent: Opera M2/7.50 (Linux, build 663)
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Apr 2004 15:46:36 +0200, Pavel Machek <pavel@ucw.cz> wrote:
> No, Herbert is right here. This *is* swsusp fault. Swsusp assumes 4MB
> tables which is not guaranteed even on PSE machines.

Okay then. Who wants to roll the patch? :>

Nigel
-- 
Nigel Cunningham
C/- Westminster Presbyterian Church Belconnen
61 Templeton Street, Cook, ACT 2614, Australia.
+61 (2) 6251 7727 (wk)
