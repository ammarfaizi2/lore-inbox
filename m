Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268526AbUI3JD5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268526AbUI3JD5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 05:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268648AbUI3JD5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 05:03:57 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:17668 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S268526AbUI3JD4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 05:03:56 -0400
In-Reply-To: <20040930042303.GS16057@certainkey.com>
References: <20040924005938.19732.qmail@science.horizon.com> <20040929171027.GJ16057@certainkey.com> <20040929193117.GB6862@thunk.org> <20040929202707.GO16057@certainkey.com> <20040929215315.GB6769@thunk.org> <20040930002100.GQ16057@certainkey.com> <20040930042303.GS16057@certainkey.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <A62FF564-12BF-11D9-B5F2-000D9352858E@linuxmail.org>
Content-Transfer-Encoding: 7bit
Cc: linux@horizon.com, "Theodore Ts'o" <tytso@mit.edu>, jmorris@redhat.com,
       linux-kernel@vger.kernel.org, cryptoapi@lists.logix.cz
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: [PROPOSAL/PATCH 2] Fortuna PRNG in /dev/random
Date: Thu, 30 Sep 2004 11:03:52 +0200
To: Jean-Luc Cooke <jlcooke@certainkey.com>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 30, 2004, at 06:23, Jean-Luc Cooke wrote:

> <fortuna-2.6.8.1.patch>

You said AES and SHA-256 _must_ be built-in, but I can't see any code 
on your patch that enforces selection of those config options. Thus, 
it's possible to compile the kernel when CONFIG_CRYPTO_SHA256=n and 
CONFIG_CRYPTO_AES=n although, of course, it will fail.

