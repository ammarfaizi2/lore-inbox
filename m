Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262902AbTLXN6q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Dec 2003 08:58:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263622AbTLXN6q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Dec 2003 08:58:46 -0500
Received: from [211.167.76.68] ([211.167.76.68]:13244 "HELO soulinfo.com")
	by vger.kernel.org with SMTP id S262902AbTLXN6n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Dec 2003 08:58:43 -0500
Date: Wed, 24 Dec 2003 21:51:20 +0800
From: Hugang <hugang@soulinfo.com>
To: Bart Samwel <bart@samwel.tk>, linux-kernel@vger.kernel.org,
       Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] laptop-mode for 2.6, version 2
Message-Id: <20031224215120.66b74f66.hugang@soulinfo.com>
In-Reply-To: <3FE92517.1000306@samwel.tk>
References: <3FE92517.1000306@samwel.tk>
Organization: Beijing Soul
X-Mailer: Sylpheed version 0.9.7claws (GTK+ 1.2.10; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Wed__24_Dec_2003_21_51_20_+0800_Bdr8Nw2URcgvVx6a"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart=_Wed__24_Dec_2003_21_51_20_+0800_Bdr8Nw2URcgvVx6a
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Dec 2003 06:33:11 +0100
Bart Samwel <bart@samwel.tk> wrote:

> Here's a new version of the laptop-mode patch (and control script). I've
> made a couple of improvements because of your comments. The block_dump
> functionality (including block dirtying) is back, and my alternative
> functionality has gone. There's just one bit of the block dumping patch 
> that I couldn't place, the bit in filemap.c. The 2.6 code is so 
> different here that I really couldn't figure out what I should do with 
> it. Do you have any idea where this has gone (and if it is still needed)?

Here is hacker patch do laptop mode on reiserfs file system. Any comments are welcome.

-- 
Hu Gang / Steve
RLU#          : 204016 [1999] (Registered Linux user)
GPG Public Key: http://soulinfo.com/~hugang/HuGang.asc

--Multipart=_Wed__24_Dec_2003_21_51_20_+0800_Bdr8Nw2URcgvVx6a
Content-Type: application/octet-stream;
 name="reiserfs_laptop_mode"
Content-Disposition: attachment;
 filename="reiserfs_laptop_mode"
Content-Transfer-Encoding: base64

SW5kZXg6IGxpbnV4LTIuNi4wL2ZzL3JlaXNlcmZzL3N1cGVyLmMKPT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQotLS0gbGlu
dXgtMi42LjAvZnMvcmVpc2VyZnMvc3VwZXIuYwkocmV2aXNpb24gOTQpCisrKyBsaW51eC0yLjYu
MC9mcy9yZWlzZXJmcy9zdXBlci5jCSh3b3JraW5nIGNvcHkpCkBAIC02NjIsNiArNjYyLDcgQEAK
IAl7InJlc2l6ZSIsICdyJywgMCwgMCwgMH0sCiAJeyJqZGV2IiwgJ2onLCAwLCAwLCAwfSwKIAl7
Im5vbGFyZ2VpbyIsICd3JywgMCwgMCwgMH0sCisJeyJjb21taXQiLCAnYycsIDAsIDAsIDB9LAog
CXtOVUxMLCAwLCAwLCAwLCAwfQogICAgIH07CiAJCkBAIC02OTAsNiArNjkxLDIxIEBACiAJICAg
IH0KIAl9CiAKKwlpZiAoIGMgPT0gJ2MnICkgeworCQlleHRlcm4gaW50IHJlaXNlcmZzX2RlZmF1
bHRfbWF4X2NvbW1pdF9hZ2U7CisJCWNoYXIgKnAgPSAwOworCQlpbnQgdmFsID0gc2ltcGxlX3N0
cnRvdWwgKGFyZywgJnAsIDApOworCisJCWlmICggKnAgIT0gJ1wwJykgeworCQkJcHJpbnRrICgi
cmVpc2VyZnNfcGFyc2Vfb3B0aW9uczogYmFkIHZhbHVlICVzXG4iLCBhcmcpOworCQkJcmV0dXJu
IDA7CisJCX0KKwkJaWYgKCB2YWwgKSAKKwkJCXJlaXNlcmZzX2RlZmF1bHRfbWF4X2NvbW1pdF9h
Z2UgPSB2YWw7CisJCWVsc2UgCisJCQlyZWlzZXJmc19kZWZhdWx0X21heF9jb21taXRfYWdlID0g
LTE7CisJfQorCiAJaWYgKCBjID09ICd3JyApIHsKIAkJY2hhciAqcD0wOwogCQlpbnQgdmFsID0g
c2ltcGxlX3N0cnRvdWwgKGFyZywgJnAsIDApOwpJbmRleDogbGludXgtMi42LjAvZnMvcmVpc2Vy
ZnMvam91cm5hbC5jCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT0KLS0tIGxpbnV4LTIuNi4wL2ZzL3JlaXNlcmZzL2pvdXJu
YWwuYwkocmV2aXNpb24gOTQpCisrKyBsaW51eC0yLjYuMC9mcy9yZWlzZXJmcy9qb3VybmFsLmMJ
KHdvcmtpbmcgY29weSkKQEAgLTE5NjQsNiArMTk2NCw4IEBACiAJcmV0dXJuIHJlc3VsdDsKIH0K
IAoraW50IHJlaXNlcmZzX2RlZmF1bHRfbWF4X2NvbW1pdF9hZ2UgPSAtMTsKKwogLyoKICoqIG11
c3QgYmUgY2FsbGVkIG9uY2Ugb24gZnMgbW91bnQuICBjYWxscyBqb3VybmFsX3JlYWQgZm9yIHlv
dQogKi8KQEAgLTIwMzIsNyArMjAzNCwxMSBAQAogICAgICAKICAgU0JfSk9VUk5BTF9UUkFOU19N
QVgocF9zX3NiKSAgICAgID0gbGUzMl90b19jcHUgKGpoLT5qaF9qb3VybmFsLmpwX2pvdXJuYWxf
dHJhbnNfbWF4KTsKICAgU0JfSk9VUk5BTF9NQVhfQkFUQ0gocF9zX3NiKSAgICAgID0gbGUzMl90
b19jcHUgKGpoLT5qaF9qb3VybmFsLmpwX2pvdXJuYWxfbWF4X2JhdGNoKTsKLSAgU0JfSk9VUk5B
TF9NQVhfQ09NTUlUX0FHRShwX3Nfc2IpID0gbGUzMl90b19jcHUgKGpoLT5qaF9qb3VybmFsLmpw
X2pvdXJuYWxfbWF4X2NvbW1pdF9hZ2UpOworICBpZiAocmVpc2VyZnNfZGVmYXVsdF9tYXhfY29t
bWl0X2FnZSAhPSAtMSkgeworCSAgU0JfSk9VUk5BTF9NQVhfQ09NTUlUX0FHRShwX3Nfc2IpID0g
cmVpc2VyZnNfZGVmYXVsdF9tYXhfY29tbWl0X2FnZTsKKyAgfSBlbHNlIHsKKwkgIFNCX0pPVVJO
QUxfTUFYX0NPTU1JVF9BR0UocF9zX3NiKSA9IGxlMzJfdG9fY3B1IChqaC0+amhfam91cm5hbC5q
cF9qb3VybmFsX21heF9jb21taXRfYWdlKTsKKyAgfQogICBTQl9KT1VSTkFMX01BWF9UUkFOU19B
R0UocF9zX3NiKSAgPSBKT1VSTkFMX01BWF9UUkFOU19BR0U7CiAKICAgaWYgKFNCX0pPVVJOQUxf
VFJBTlNfTUFYKHBfc19zYikpIHsKSW5kZXg6IGxpbnV4LTIuNi4wL2ZzL3JlaXNlcmZzL3Byb2Nm
cy5jCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT0KLS0tIGxpbnV4LTIuNi4wL2ZzL3JlaXNlcmZzL3Byb2Nmcy5jCShyZXZp
c2lvbiA5NCkKKysrIGxpbnV4LTIuNi4wL2ZzL3JlaXNlcmZzL3Byb2Nmcy5jCSh3b3JraW5nIGNv
cHkpCkBAIC00MDEsNyArNDAxLDcgQEAKICAgICAgICAgICAgICAgICAgICAgICAgIERKUCgganBf
am91cm5hbF90cmFuc19tYXggKSwKICAgICAgICAgICAgICAgICAgICAgICAgIERKUCgganBfam91
cm5hbF9tYWdpYyApLAogICAgICAgICAgICAgICAgICAgICAgICAgREpQKCBqcF9qb3VybmFsX21h
eF9iYXRjaCApLAotICAgICAgICAgICAgICAgICAgICAgICAgREpQKCBqcF9qb3VybmFsX21heF9j
b21taXRfYWdlICksCisgICAgICAgICAgICAgICAgICAgICAgICBTQl9KT1VSTkFMX01BWF9DT01N
SVRfQUdFKHNiKSwgCiAgICAgICAgICAgICAgICAgICAgICAgICBESlAoIGpwX2pvdXJuYWxfbWF4
X3RyYW5zX2FnZSApLAogCiAJCQlKRiggal8xc3RfcmVzZXJ2ZWRfYmxvY2sgKSwJCQkK

--Multipart=_Wed__24_Dec_2003_21_51_20_+0800_Bdr8Nw2URcgvVx6a--
