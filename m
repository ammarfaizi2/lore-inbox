Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265909AbSLSS4I>; Thu, 19 Dec 2002 13:56:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265939AbSLSS4I>; Thu, 19 Dec 2002 13:56:08 -0500
Received: from fmr01.intel.com ([192.55.52.18]:58572 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S265909AbSLSS4I>;
	Thu, 19 Dec 2002 13:56:08 -0500
Message-ID: <A46BBDB345A7D5118EC90002A5072C7806CACA31@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'Robert Love'" <rml@tech9.net>
Cc: linux-kernel@vger.kernel.org
Subject: RE: [PATCH 2.5.52] Use __set_current_state() instead of current->
	 state = (take 1)
Date: Thu, 19 Dec 2002 11:04:06 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > And that would now really work when CONFIG_X86_OOSTORE=1 is required
> > [after all, it is a write, so it'd need the equivalent of a wmb() or
> > xchg()].
> 
> Is this a hint that your employer may have an x86 chip in the future
> with weak ordering? :)

Hmmm ... taking into account that there are some many thousands of
employees in my company and that I know less than one hundred ...
and that they are all software ... well, I don't think I am into
the rumour mill :]

Inaky Perez-Gonzalez -- Not speaking for Intel - opinions are my own [or my
fault]

