Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266427AbUHFDhf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266427AbUHFDhf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 23:37:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266334AbUHFDhe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 23:37:34 -0400
Received: from [203.178.140.15] ([203.178.140.15]:11018 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S266256AbUHFDf4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 23:35:56 -0400
Date: Thu, 05 Aug 2004 20:36:23 -0700 (PDT)
Message-Id: <20040805.203623.60258238.yoshfuji@linux-ipv6.org>
To: jmorris@redhat.com
Cc: jlcooke@certainkey.com, mludvig@suse.cz, cryptoapi@lists.logix.cz,
       linux-kernel@vger.kernel.org, davem@redhat.com, yoshfuji@linux-ipv6.org
Subject: Re: [PATCH]
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <Xine.LNX.4.44.0408052245380.20516-100000@dhcp83-76.boston.redhat.com>
References: <20040805194914.GC23994@certainkey.com>
	<Xine.LNX.4.44.0408052245380.20516-100000@dhcp83-76.boston.redhat.com>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Xine.LNX.4.44.0408052245380.20516-100000@dhcp83-76.boston.redhat.com> (at Thu, 5 Aug 2004 22:47:12 -0400 (EDT)), James Morris <jmorris@redhat.com> says:

> > Would you be against a patch to cryptoapi to have access to a
> > non-scatter-list set of calls?
:
> level.  Can you demonstrate a compelling need for raw access to the
> algorithms via the API?

I would use them for
 - Privacy Extensions (RFC3041) support
 - upcoming TCP MD5 signature (RFC2385) support
since I don't see the advantage(s) of sg for allocated memories there.

--yoshfuji
