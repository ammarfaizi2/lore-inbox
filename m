Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261723AbVAXXT7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261723AbVAXXT7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 18:19:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261708AbVAXXTU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 18:19:20 -0500
Received: from palrel13.hp.com ([156.153.255.238]:46471 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S261723AbVAXW6h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 17:58:37 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16885.32149.788747.550216@napali.hpl.hp.com>
Date: Mon, 24 Jan 2005 14:58:29 -0800
To: Keith Owens <kaos@ocs.com.au>
Cc: davidm@hpl.hp.com, bgerst@didntduck.org,
       Terence Ripperda <tripperda@nvidia.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: inter_module_get and __symbol_get 
In-Reply-To: <31189.1106607276@ocs3.ocs.com.au>
References: <16885.31766.730042.408639@napali.hpl.hp.com>
	<31189.1106607276@ocs3.ocs.com.au>
X-Mailer: VM 7.19 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Tue, 25 Jan 2005 09:54:36 +1100, Keith Owens <kaos@ocs.com.au> said:

  Keith> Does DRM support this model?

  Keith> * Start DRM without AGP.
  Keith> * AGP is loaded.
  Keith> * DRM continues but now using AGP.

  Keith> If yes then it needs dynamic symbol resolution.

I think it does, but I don't see any advantages to it (not on the
machines I'm using, at least).  In fact, I'd rather have an explicit
dependency on AGP.

	--david
