Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265149AbTIJQWc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 12:22:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265158AbTIJQWb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 12:22:31 -0400
Received: from anacreon.polito.it ([130.192.3.82]:38415 "EHLO polito.it")
	by vger.kernel.org with ESMTP id S265149AbTIJQW3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 12:22:29 -0400
Message-ID: <3F5F4F96.4050000@gentoo.org>
Date: Wed, 10 Sep 2003 18:21:42 +0200
From: Luca Barbato <lu_zero@gentoo.org>
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-US; rv:1.4) Gecko/20030818
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: cryptoapi-devel@kerneli.org
CC: linux-kernel@vger.kernel.org
Subject: cryptoloop extended for compressors.
X-Enigmail-Version: 0.76.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I'm porting cloop ideas from the 2.4 kernel to 2.6 and I'm basically 
extending the current cryptoloop to support compressors and not just 
ciphers. If someone interested wants take a look 
http://dev.gentoo.org/~lu_zero/gcloop contains some patch snapshots, and 
userspace utilities.

It isn't yet completed and the ucl module (that I'm using as 
decompressor) needs to incorporate libucl.a currently, you should copy 
it to crypto/ (probably one of the worst thing to do, but works fine for 
testing).

Regards

lu

-- 
Luca Barbato
Developer
Gentoo Linux				http://www.gentoo.org/~lu_zero



