Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261789AbVCHDIe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261789AbVCHDIe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 22:08:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261275AbVCGU1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 15:27:24 -0500
Received: from mailer.campus.mipt.ru ([194.85.82.4]:64176 "EHLO
	mailer.campus.mipt.ru") by vger.kernel.org with ESMTP
	id S261772AbVCGUM3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 15:12:29 -0500
Cc: Fruhwirth Clemens <clemens@endorphin.org>,
       Herbert Xu <herbert@gondor.apana.org.au>, cryptoapi@lists.logix.cz,
       James Morris <jmorris@redhat.com>, David Miller <davem@davemloft.net>,
       Andrew Morton <akpm@osdl.org>, Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Subject: [5/5] bd: script for unbinding any filters
In-Reply-To: <11102278591373@2ka.mipt.ru>
X-Mailer: gregkh_patchbomb
Date: Mon, 7 Mar 2005 23:37:39 +0300
Message-Id: <11102278593982@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (mailer.campus.mipt.ru [194.85.82.4]); Mon, 07 Mar 2005 23:11:25 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

./ubd unbind dev /dev/bd0 filter acrypto 
./ubd unbind dev /dev/bd0 filter xor
./ubd unbind dev /dev/bd0 filter fd

