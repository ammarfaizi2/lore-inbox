Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265648AbUA0TnR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 14:43:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265755AbUA0TnQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 14:43:16 -0500
Received: from 104.engsoc.carleton.ca ([134.117.69.104]:24484 "EHLO
	quickman.certainkey.com") by vger.kernel.org with ESMTP
	id S265648AbUA0TnI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 14:43:08 -0500
Date: Tue, 27 Jan 2004 14:39:45 -0500
From: Jean-Luc Cooke <jlcooke@certainkey.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] crypto/sha256.c crypto/sha512.c
Message-ID: <20040127193945.GA15559@certainkey.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Optimized the choice and majority fuctions a bit.

Patch:
  http://jlcooke.ca/lkml/faster_sha2.patch

Test suite:
  http://jlcooke.ca/lkml/faster_sha2.c
  build with:
    gcc -O3 -s faster_sha2.c -o faster_sha2

JLC

-- 
http://www.certainkey.com
Suite 4560 CTTC
1125 Colonel By Dr.
Ottawa ON, K1S 5B6
