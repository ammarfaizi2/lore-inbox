Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267489AbSLSA43>; Wed, 18 Dec 2002 19:56:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267490AbSLSA43>; Wed, 18 Dec 2002 19:56:29 -0500
Received: from fmr06.intel.com ([134.134.136.7]:38341 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id <S267489AbSLSA41>; Wed, 18 Dec 2002 19:56:27 -0500
Message-ID: <A46BBDB345A7D5118EC90002A5072C7806CACA2C@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'Till Immanuel Patzschke'" <tip@inw.de>,
       lse-tech <lse-tech@lists.sourceforge.net>, linux-kernel@vger.kernel.org
Subject: RE: 15000+ processes -- poor performance ?!
Date: Wed, 18 Dec 2002 17:04:16 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> forgot the kernel version (2.4.20aa1)...

You need the O(1) scheduler; not sure if aa has it or not; if not, lots of
processes will suck your machine. I think -ac has the O(1) scheduler, or try
2.5. The old scheduler is pretty cool but not as scalable as the new one.

If it has it ... well, I have no idea - maybe Robert Love would know.

Inaky Perez-Gonzalez -- Not speaking for Intel - opinions are my own [or my
fault]

