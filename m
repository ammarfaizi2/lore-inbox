Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262021AbVDVKI3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262021AbVDVKI3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 06:08:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262023AbVDVKI2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 06:08:28 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:43757 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262021AbVDVKAR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 06:00:17 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: herbert@gondor.apana.org.au, davem@davemloft.net
Subject: [PATCH extra/3] crypto: random changes
Date: Fri, 22 Apr 2005 12:59:06 +0300
User-Agent: KMail/1.5.4
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504221259.06596.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This one is for comments only.

These changes were found to bring small size/speed
improvements by use of BYTEn() and other changes.

des.c can be less heavily unrolled, 10k -> 5k in object size.

Any objections to this?
--
vda

