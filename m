Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932141AbWEWOXE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932141AbWEWOXE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 10:23:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932154AbWEWOXE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 10:23:04 -0400
Received: from dspnet.fr.eu.org ([213.186.44.138]:21777 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S932141AbWEWOXD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 10:23:03 -0400
Date: Tue, 23 May 2006 16:23:02 +0200
From: Olivier Galibert <galibert@pobox.com>
To: Ivan Novick <ivan@0x4849.net>
Cc: Nuri Jawad <lkml@jawad.org>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
       julian@valgrind.org
Subject: Re: Linux Kernel Source Compression
Message-ID: <20060523142302.GA45392@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Ivan Novick <ivan@0x4849.net>, Nuri Jawad <lkml@jawad.org>,
	Alistair John Strachan <s0348365@sms.ed.ac.uk>,
	Jan Engelhardt <jengelh@linux01.gwdg.de>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
	julian@valgrind.org
References: <Pine.LNX.4.64.0605211028100.4037@p34> <200605222015.01980.s0348365@sms.ed.ac.uk> <Pine.LNX.4.61.0605222220190.6816@yvahk01.tjqt.qr> <200605222200.18351.s0348365@sms.ed.ac.uk> <Pine.LNX.4.64.0605230407320.25860@pc> <1148393727.14381.262121289@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1148393727.14381.262121289@webmail.messagingengine.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> just wanted to remark that I never liked that bzip was replaced by bzip2 
> (were there license issues?) since bzip's compression was/is often 
> stronger:

bzip1 uses arithmetic encoding which is heavily patented.  bzip2 uses
huffman instead, which isn't, but is slightly (10% is often quoted)
less efficient.  I guess bzip3 could use range coding which is
supposedly patent-free[1] and has similar compression ratio than
arithmetic coding.

  OG.

[1] I guess everything is in the way it is written, since I have a
very hard time understand where the difference is between range coding
and arithmetic coding.
