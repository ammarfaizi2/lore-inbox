Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965164AbVITVqQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965164AbVITVqQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 17:46:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965162AbVITVqP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 17:46:15 -0400
Received: from mf00.sitadelle.com ([212.94.174.67]:26144 "EHLO
	smtp.cegetel.net") by vger.kernel.org with ESMTP id S965164AbVITVqP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 17:46:15 -0400
Message-ID: <43308324.70403@cosmosbay.com>
Date: Tue, 20 Sep 2005 23:46:12 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       netfilter-devel@lists.netfilter.org, netdev@vger.kernel.org
Subject: [PATCH] Adds sys_set_mempolicy() in include/linux/syscalls.h
References: <432EF0C5.5090908@cosmosbay.com> <200509191948.55333.ak@suse.de> <432FDAC5.3040801@cosmosbay.com> <200509201830.20689.ak@suse.de> <433082DE.3060308@cosmosbay.com>
In-Reply-To: <433082DE.3060308@cosmosbay.com>
Content-Type: multipart/mixed;
 boundary="------------050908050002000101040806"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050908050002000101040806
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Andi Kleen a écrit :

 > On Tuesday 20 September 2005 11:47, Eric Dumazet wrote:
 >
 >
 >
 > I would prefer if random code didn't mess with mempolicy internals
 > like this. Better just call sys_set_mempolicy()
 > -Andi
 >
 >


OK but this prior patch seems necessary :

- Adds sys_set_mempolicy() in include/linux/syscalls.h

Signed-off-by: Eric Dumazet <dada1@cosmosbay.com>




--------------050908050002000101040806
Content-Type: text/plain;
 name="patch_add_sys_set_mempolicy"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="patch_add_sys_set_mempolicy"

LS0tIGxpbnV4LTIuNi9pbmNsdWRlL2xpbnV4L3N5c2NhbGxzLmgJMjAwNS0wOS0wNiAwMToy
MDoyMS4wMDAwMDAwMDAgKzAyMDAKKysrIGxpbnV4LTIuNi1lZC9pbmNsdWRlL2xpbnV4L3N5
c2NhbGxzLmgJMjAwNS0wOS0yMCAyMzo0MzowNy4wMDAwMDAwMDAgKzAyMDAKQEAgLTUwOCw1
ICs1MDgsNyBAQAogCiBhc21saW5rYWdlIGxvbmcgc3lzX2lvcHJpb19zZXQoaW50IHdoaWNo
LCBpbnQgd2hvLCBpbnQgaW9wcmlvKTsKIGFzbWxpbmthZ2UgbG9uZyBzeXNfaW9wcmlvX2dl
dChpbnQgd2hpY2gsIGludCB3aG8pOworYXNtbGlua2FnZSBsb25nIHN5c19zZXRfbWVtcG9s
aWN5KGludCBtb2RlLCB1bnNpZ25lZCBsb25nIF9fdXNlciAqbm1hc2ssCisJCQkJCXVuc2ln
bmVkIGxvbmcgbWF4bm9kZSk7CiAKICNlbmRpZgo=
--------------050908050002000101040806--
