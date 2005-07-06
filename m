Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262474AbVGFVyz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262474AbVGFVyz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 17:54:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262483AbVGFUKS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 16:10:18 -0400
Received: from chretien.genwebhost.com ([209.59.175.22]:9443 "EHLO
	chretien.genwebhost.com") by vger.kernel.org with ESMTP
	id S262473AbVGFTKF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 15:10:05 -0400
Date: Wed, 6 Jul 2005 12:09:57 -0700
From: randy_dunlap <rdunlap@xenotime.net>
To: =?ISO-8859-1?B?TWljaGFfXw==?= Piotrowski 
	<piotrowskim@trex.wsi.edu.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc2 white spaces patch
Message-Id: <20050706120957.1a88b46f.rdunlap@xenotime.net>
In-Reply-To: <42CBDF6D.8090802@trex.wsi.edu.pl>
References: <42CBDF6D.8090802@trex.wsi.edu.pl>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-ClamAntiVirus-Scanner: This mail is clean
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - chretien.genwebhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - xenotime.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 06 Jul 2005 15:41:01 +0200 Micha__ Piotrowski wrote:

| Hi,
| 
| This patch is against 2.6.13-rc2. It cleans whitespaces in init/* and 
| crypto/*.

General comment:  needs a Signed-off-by: line (see
Documenation/SubmittingPatches ).

Howver, I am having trouble seeing changes in lots of the
-/+ lines.  Did thunderbird perhaps mangle your patch?

After that is fixed, we can see if it's worthwhile to do this
kind of patch....  (some doubt here)


| Regards,
| Micha__ Piotrowski
| 
| ---
| 
| diff -uprN -X linux-2.6.13-rc2/Documentation/dontdiff 
| linux-2.6.13-rc2/crypto/aes.c linux-2.6.13-rc2-ws/crypto/aes.c
| --- linux-2.6.13-rc2/crypto/aes.c    2005-06-17 21:48:29.000000000 +0200
| +++ linux-2.6.13-rc2-ws/crypto/aes.c    2005-07-06 15:14:45.000000000 +0200
| @@ -1,4 +1,4 @@
| -/*
| +/*
|   * Cryptographic API.
|   *
|   * AES Cipher Algorithm.
| @@ -65,7 +65,7 @@
|  #define AES_BLOCK_SIZE        16
|  
|  /*
| - * #define byte(x, nr) ((unsigned char)((x) >> (nr*8)))
| + * #define byte(x, nr) ((unsigned char)((x) >> (nr*8)))
|   */
|  inline static u8
|  byte(const u32 x, const unsigned n)
| diff -uprN -X linux-2.6.13-rc2/Documentation/dontdiff 
| linux-2.6.13-rc2/crypto/api.c linux-2.6.13-rc2-ws/crypto/api.c
| --- linux-2.6.13-rc2/crypto/api.c    2005-06-17 21:48:29.000000000 +0200
| +++ linux-2.6.13-rc2-ws/crypto/api.c    2005-07-06 15:14:57.000000000 +0200
| @@ -9,7 +9,7 @@
|   *
|   * This program is free software; you can redistribute it and/or modify it
|   * under the terms of the GNU General Public License as published by 
| the Free
| - * Software Foundation; either version 2 of the License, or (at your 
| option)
| + * Software Foundation; either version 2 of the License, or (at your 
| option)
|   * any later version.
|   *
|   */
| diff -uprN -X linux-2.6.13-rc2/Documentation/dontdiff 
| linux-2.6.13-rc2/crypto/arc4.c linux-2.6.13-rc2-ws/crypto/arc4.c
| --- linux-2.6.13-rc2/crypto/arc4.c    2005-06-17 21:48:29.000000000 +0200
| +++ linux-2.6.13-rc2-ws/crypto/arc4.c    2005-07-06 15:15:09.000000000 +0200
| @@ -1,4 +1,4 @@
| -/*
| +/*
|   * Cryptographic API
|   *
|   * ARC4 Cipher Algorithm
| diff -uprN -X linux-2.6.13-rc2/Documentation/dontdiff 
| linux-2.6.13-rc2/crypto/blowfish.c linux-2.6.13-rc2-ws/crypto/blowfish.c
| --- linux-2.6.13-rc2/crypto/blowfish.c    2005-06-17 21:48:29.000000000 
| +0200
| +++ linux-2.6.13-rc2-ws/crypto/blowfish.c    2005-07-06 
| 15:16:07.000000000 +0200
| @@ -1,4 +1,4 @@
| -/*
| +/*
|   * Cryptographic API.
|   *
|   * Blowfish Cipher Algorithm, by Bruce Schneier.
| @@ -298,7 +298,7 @@ static const u32 bf_sbox[256 * 4] = {
|      0xb74e6132, 0xce77e25b, 0x578fdfe3, 0x3ac372e6,
|  };
|  
| -/*
| +/*
|   * Round loop unrolling macros, S is a pointer to a S-Box array
|   * organized in 4 unsigned longs at a row.
|   */
| @@ -314,7 +314,7 @@ static const u32 bf_sbox[256 * 4] = {
|  
|  /*
|   * The blowfish encipher, processes 64-bit blocks.
| - * NOTE: This function MUSTN'T respect endianess
| + * NOTE: This function MUSTN'T respect endianess
|   */
|  static void encrypt_block(struct bf_ctx *bctx, u32 *dst, u32 *src)
|  {
| @@ -393,7 +393,7 @@ static void bf_decrypt(void *ctx, u8 *ds
|      out_blk[1] = cpu_to_be32(yl);
|  }
|  
| -/*
| +/*
|   * Calculates the blowfish S and P boxes for encryption and decryption.
|   */
|  static int bf_setkey(void *ctx, const u8 *key, unsigned int keylen, u32 
| *flags)
| diff -uprN -X linux-2.6.13-rc2/Documentation/dontdiff 
| linux-2.6.13-rc2/crypto/cast6.c linux-2.6.13-rc2-ws/crypto/cast6.c
| --- linux-2.6.13-rc2/crypto/cast6.c    2005-06-17 21:48:29.000000000 +0200
| +++ linux-2.6.13-rc2-ws/crypto/cast6.c    2005-07-06 15:16:53.000000000 
| +0200
| @@ -11,7 +11,7 @@
|   * under the terms of GNU General Public License as published by the Free
|   * Software Foundation; either version 2 of the License, or (at your 
| option)
|   * any later version.
| - *
| + *
|   * You should have received a copy of the GNU General Public License
|   * along with this program; if not, write to the Free Software
|   * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 
| 02111-1307, USA
| @@ -310,7 +310,7 @@ static const u32 s4[256] = {
|  
|  static const u32 Tm[24][8] = {
|      { 0x5a827999, 0xc95c653a, 0x383650db, 0xa7103c7c, 0x15ea281d,
| -        0x84c413be, 0xf39dff5f, 0x6277eb00 } ,
| +        0x84c413be, 0xf39dff5f, 0x6277eb00 } ,
|      { 0xd151d6a1, 0x402bc242, 0xaf05ade3, 0x1ddf9984, 0x8cb98525,
|          0xfb9370c6, 0x6a6d5c67, 0xd9474808 } ,
|      { 0x482133a9, 0xb6fb1f4a, 0x25d50aeb, 0x94aef68c, 0x0388e22d,
| @@ -445,7 +445,7 @@ static inline void QBAR (u32 * block, u8
|  static void cast6_encrypt (void * ctx, u8 * outbuf, const u8 * inbuf) {
|      struct cast6_ctx * c = (struct cast6_ctx *)ctx;
|      u32 block[4];
| -    u32 * Km;
| +    u32 * Km;
|      u8 * Kr;
|  
|      block[0] = inbuf[0] << 24 | inbuf[1] << 16 | inbuf[2] << 8 | inbuf[3];
| @@ -487,7 +487,7 @@ static void cast6_encrypt (void * ctx, u
|  static void cast6_decrypt (void * ctx, u8 * outbuf, const u8 * inbuf) {
|      struct cast6_ctx * c = (struct cast6_ctx *)ctx;
|      u32 block[4];
| -    u32 * Km;
| +    u32 * Km;
|      u8 * Kr;
|  
|      block[0] = inbuf[0] << 24 | inbuf[1] << 16 | inbuf[2] << 8 | inbuf[3];
| diff -uprN -X linux-2.6.13-rc2/Documentation/dontdiff 
| linux-2.6.13-rc2/crypto/cipher.c linux-2.6.13-rc2-ws/crypto/cipher.c
| --- linux-2.6.13-rc2/crypto/cipher.c    2005-06-17 21:48:29.000000000 +0200
| +++ linux-2.6.13-rc2-ws/crypto/cipher.c    2005-07-06 15:17:19.000000000 
| +0200
| @@ -7,7 +7,7 @@
|   *
|   * This program is free software; you can redistribute it and/or modify it
|   * under the terms of the GNU General Public License as published by 
| the Free
| - * Software Foundation; either version 2 of the License, or (at your 
| option)
| + * Software Foundation; either version 2 of the License, or (at your 
| option)
|   * any later version.
|   *
|   */
| @@ -39,7 +39,7 @@ static inline void xor_128(u8 *a, const
|      ((u32 *)a)[2] ^= ((u32 *)b)[2];
|      ((u32 *)a)[3] ^= ((u32 *)b)[3];
|  }
| -
| +
|  static inline void *prepare_src(struct scatter_walk *walk, int bsize,
|                  void *tmp, int in_place)
|  {
| @@ -81,7 +81,7 @@ static inline void complete_dst(struct s
|      scatterwalk_advance(walk, n);
|  }
|  
| -/*
| +/*
|   * Generic encrypt/decrypt wrapper for ciphers, handles operations across
|   * multiple page boundaries by using temporary blocks.  In user context,
|   * the kernel is given a chance to schedule us once per block.
| diff -uprN -X linux-2.6.13-rc2/Documentation/dontdiff 
| linux-2.6.13-rc2/crypto/compress.c linux-2.6.13-rc2-ws/crypto/compress.c
| --- linux-2.6.13-rc2/crypto/compress.c    2005-06-17 21:48:29.000000000 
| +0200
| +++ linux-2.6.13-rc2-ws/crypto/compress.c    2005-07-06 
| 15:17:29.000000000 +0200
| @@ -7,7 +7,7 @@
|   *
|   * This program is free software; you can redistribute it and/or modify it
|   * under the terms of the GNU General Public License as published by 
| the Free
| - * Software Foundation; either version 2 of the License, or (at your 
| option)
| + * Software Foundation; either version 2 of the License, or (at your 
| option)
|   * any later version.
|   *
|   */
| diff -uprN -X linux-2.6.13-rc2/Documentation/dontdiff 
| linux-2.6.13-rc2/crypto/crc32c.c linux-2.6.13-rc2-ws/crypto/crc32c.c
| --- linux-2.6.13-rc2/crypto/crc32c.c    2005-06-17 21:48:29.000000000 +0200
| +++ linux-2.6.13-rc2-ws/crypto/crc32c.c    2005-07-06 15:17:51.000000000 
| +0200
| @@ -1,4 +1,4 @@
| -/*
| +/*
|   * Cryptographic API.
|   *
|   * CRC32C chksum
| @@ -7,7 +7,7 @@
|   *
|   * This program is free software; you can redistribute it and/or modify it
|   * under the terms of the GNU General Public License as published by 
| the Free
| - * Software Foundation; either version 2 of the License, or (at your 
| option)
| + * Software Foundation; either version 2 of the License, or (at your 
| option)
|   * any later version.
|   *
|   */
| @@ -26,7 +26,7 @@ struct chksum_ctx {
|  };
|  
|  /*
| - * Steps through buffer one byte at at time, calculates reflected
| + * Steps through buffer one byte at at time, calculates reflected
|   * crc using table.
|   */
|  
| diff -uprN -X linux-2.6.13-rc2/Documentation/dontdiff 
| linux-2.6.13-rc2/crypto/crypto_null.c 
| linux-2.6.13-rc2-ws/crypto/crypto_null.c
| --- linux-2.6.13-rc2/crypto/crypto_null.c    2005-06-17 
| 21:48:29.000000000 +0200
| +++ linux-2.6.13-rc2-ws/crypto/crypto_null.c    2005-07-06 
| 15:18:03.000000000 +0200
| @@ -1,11 +1,11 @@
| -/*
| +/*
|   * Cryptographic API.
|   *
|   * Null algorithms, aka Much Ado About Nothing.
|   *
|   * These are needed for IPsec, and may be useful in general for
|   * testing & debugging.
| - *
| + *
|   * The null cipher is compliant with RFC2410.
|   *
|   * Copyright (c) 2002 James Morris <jmorris@intercode.com.au>
| diff -uprN -X linux-2.6.13-rc2/Documentation/dontdiff 
| linux-2.6.13-rc2/crypto/deflate.c linux-2.6.13-rc2-ws/crypto/deflate.c
| --- linux-2.6.13-rc2/crypto/deflate.c    2005-06-17 21:48:29.000000000 +0200
| +++ linux-2.6.13-rc2-ws/crypto/deflate.c    2005-07-06 
| 15:18:32.000000000 +0200
| @@ -1,14 +1,14 @@
| -/*
| +/*
|   * Cryptographic API.
|   *
|   * Deflate algorithm (RFC 1951), implemented here primarily for use
|   * by IPCOMP (RFC 3173 & RFC 2394).
|   *
|   * Copyright (c) 2003 James Morris <jmorris@intercode.com.au>
| - *
| + *
|   * This program is free software; you can redistribute it and/or modify it
|   * under the terms of the GNU General Public License as published by 
| the Free
| - * Software Foundation; either version 2 of the License, or (at your 
| option)
| + * Software Foundation; either version 2 of the License, or (at your 
| option)
|   * any later version.
|   *
|   * FIXME: deflate transforms will require up to a total of about 436k 
| of kernel
| @@ -151,7 +151,7 @@ static int deflate_compress(void *ctx, c
|  out:
|      return ret;
|  }
| -
| +
|  static int deflate_decompress(void *ctx, const u8 *src, unsigned int slen,
|                                u8 *dst, unsigned int *dlen)
|  {
| @@ -180,7 +180,7 @@ static int deflate_decompress(void *ctx,
|      if (ret == Z_OK && !stream->avail_in && stream->avail_out) {
|          u8 zerostuff = 0;
|          stream->next_in = &zerostuff;
| -        stream->avail_in = 1;
| +        stream->avail_in = 1;
|          ret = zlib_inflate(stream, Z_FINISH);
|      }
|      if (ret != Z_STREAM_END) {
| diff -uprN -X linux-2.6.13-rc2/Documentation/dontdiff 
| linux-2.6.13-rc2/crypto/des.c linux-2.6.13-rc2-ws/crypto/des.c
| --- linux-2.6.13-rc2/crypto/des.c    2005-06-17 21:48:29.000000000 +0200
| +++ linux-2.6.13-rc2-ws/crypto/des.c    2005-07-06 15:19:18.000000000 +0200
| @@ -1,4 +1,4 @@
| -/*
| +/*
|   * Cryptographic API.
|   *
|   * DES & Triple DES EDE Cipher Algorithms.
| @@ -9,7 +9,7 @@
|   * scatterlist interface.  Changed LGPL to GPL per section 3 of the LGPL.
|   *
|   * Copyright (c) 1992 Dana L. How.
| - * Copyright (c) Raimar Falke <rf13@inf.tu-dresden.de>
| + * Copyright (c) Raimar Falke <rf13@inf.tu-dresden.de>
|   * Copyright (c) Gisle S__lensminde <gisle@ii.uib.no>
|   * Copyright (C) 2001 Niels Möller.
|   * Copyright (c) 2002 James Morris <jmorris@intercode.com.au>
| @@ -1185,7 +1185,7 @@ static void des_decrypt(void *ctx, u8 *d
|      des_small_fips_decrypt(((struct des_ctx *)ctx)->expkey, dst, src);
|  }
|  
| -/*
| +/*
|   * RFC2451:
|   *
|   *   For DES-EDE3, there is no known need to reject weak or
| @@ -1204,7 +1204,7 @@ static int des3_ede_setkey(void *ctx, co
|      unsigned int i, off;
|      struct des3_ede_ctx *dctx = ctx;
|  
| -    if (!(memcmp(key, &key[DES_KEY_SIZE], DES_KEY_SIZE) &&
| +    if (!(memcmp(key, &key[DES_KEY_SIZE], DES_KEY_SIZE) &&
|          memcmp(&key[DES_KEY_SIZE], &key[DES_KEY_SIZE * 2],
|                              DES_KEY_SIZE))) {
|  
| diff -uprN -X linux-2.6.13-rc2/Documentation/dontdiff 
| linux-2.6.13-rc2/crypto/digest.c linux-2.6.13-rc2-ws/crypto/digest.c
| --- linux-2.6.13-rc2/crypto/digest.c    2005-06-17 21:48:29.000000000 +0200
| +++ linux-2.6.13-rc2-ws/crypto/digest.c    2005-07-06 15:19:51.000000000 
| +0200
| @@ -7,7 +7,7 @@
|   *
|   * This program is free software; you can redistribute it and/or modify it
|   * under the terms of the GNU General Public License as published by 
| the Free
| - * Software Foundation; either version 2 of the License, or (at your 
| option)
| + * Software Foundation; either version 2 of the License, or (at your 
| option)
|   * any later version.
|   *
|   */
| @@ -36,7 +36,7 @@ static void update(struct crypto_tfm *tf
|  
|          do {
|              unsigned int bytes_from_page = min(l, ((unsigned int)
| -                               (PAGE_SIZE)) -
| +                               (PAGE_SIZE)) -
|                                 offset);
|              char *p = crypto_kmap(pg, 0) + offset;
|  
| diff -uprN -X linux-2.6.13-rc2/Documentation/dontdiff 
| linux-2.6.13-rc2/crypto/hmac.c linux-2.6.13-rc2-ws/crypto/hmac.c
| --- linux-2.6.13-rc2/crypto/hmac.c    2005-06-17 21:48:29.000000000 +0200
| +++ linux-2.6.13-rc2-ws/crypto/hmac.c    2005-07-06 15:20:12.000000000 +0200
| @@ -10,7 +10,7 @@
|   *
|   * This program is free software; you can redistribute it and/or modify it
|   * under the terms of the GNU General Public License as published by 
| the Free
| - * Software Foundation; either version 2 of the License, or (at your 
| option)
| + * Software Foundation; either version 2 of the License, or (at your 
| option)
|   * any later version.
|   *
|   */
| diff -uprN -X linux-2.6.13-rc2/Documentation/dontdiff 
| linux-2.6.13-rc2/crypto/internal.h linux-2.6.13-rc2-ws/crypto/internal.h
| --- linux-2.6.13-rc2/crypto/internal.h    2005-06-17 21:48:29.000000000 
| +0200
| +++ linux-2.6.13-rc2-ws/crypto/internal.h    2005-07-06 
| 15:20:24.000000000 +0200
| @@ -5,7 +5,7 @@
|   *
|   * This program is free software; you can redistribute it and/or modify it
|   * under the terms of the GNU General Public License as published by 
| the Free
| - * Software Foundation; either version 2 of the License, or (at your 
| option)
| + * Software Foundation; either version 2 of the License, or (at your 
| option)
|   * any later version.
|   *
|   */
| diff -uprN -X linux-2.6.13-rc2/Documentation/dontdiff 
| linux-2.6.13-rc2/crypto/khazad.c linux-2.6.13-rc2-ws/crypto/khazad.c
| --- linux-2.6.13-rc2/crypto/khazad.c    2005-06-17 21:48:29.000000000 +0200
| +++ linux-2.6.13-rc2-ws/crypto/khazad.c    2005-07-06 15:20:51.000000000 
| +0200
| @@ -795,7 +795,7 @@ static int khazad_setkey(void *ctx_arg,
|                  T6[(int)(K1 >>  8) & 0xff] ^
|                  T7[(int)(K1      ) & 0xff] ^
|                  c[r] ^ K2;
| -        K2 = K1;
| +        K2 = K1;
|          K1 = ctx->E[r];
|      }
|      /* Setup the decrypt key */
| diff -uprN -X linux-2.6.13-rc2/Documentation/dontdiff 
| linux-2.6.13-rc2/crypto/md4.c linux-2.6.13-rc2-ws/crypto/md4.c
| --- linux-2.6.13-rc2/crypto/md4.c    2005-06-17 21:48:29.000000000 +0200
| +++ linux-2.6.13-rc2-ws/crypto/md4.c    2005-07-06 15:21:05.000000000 +0200
| @@ -1,4 +1,4 @@
| -/*
| +/*
|   * Cryptographic API.
|   *
|   * MD4 Message Digest Algorithm (RFC1320).
| @@ -57,7 +57,7 @@ static inline u32 H(u32 x, u32 y, u32 z)
|  {
|      return x ^ y ^ z;
|  }
| -                       
| +
|  #define ROUND1(a,b,c,d,k,s) (a = lshift(a + F(b,c,d) + k, s))
|  #define ROUND2(a,b,c,d,k,s) (a = lshift(a + G(b,c,d) + k + 
| (u32)0x5A827999,s))
|  #define ROUND3(a,b,c,d,k,s) (a = lshift(a + H(b,c,d) + k + 
| (u32)0x6ED9EBA1,s))
| diff -uprN -X linux-2.6.13-rc2/Documentation/dontdiff 
| linux-2.6.13-rc2/crypto/md5.c linux-2.6.13-rc2-ws/crypto/md5.c
| --- linux-2.6.13-rc2/crypto/md5.c    2005-06-17 21:48:29.000000000 +0200
| +++ linux-2.6.13-rc2-ws/crypto/md5.c    2005-07-06 15:21:34.000000000 +0200
| @@ -1,4 +1,4 @@
| -/*
| +/*
|   * Cryptographic API.
|   *
|   * MD5 Message Digest Algorithm (RFC1321).
| @@ -8,10 +8,10 @@
|   *
|   * Copyright (c) Cryptoapi developers.
|   * Copyright (c) 2002 James Morris <jmorris@intercode.com.au>
| - *
| + *
|   * This program is free software; you can redistribute it and/or modify it
|   * under the terms of the GNU General Public License as published by 
| the Free
| - * Software Foundation; either version 2 of the License, or (at your 
| option)
| + * Software Foundation; either version 2 of the License, or (at your 
| option)
|   * any later version.
|   *
|   */
| diff -uprN -X linux-2.6.13-rc2/Documentation/dontdiff 
| linux-2.6.13-rc2/crypto/proc.c linux-2.6.13-rc2-ws/crypto/proc.c
| --- linux-2.6.13-rc2/crypto/proc.c    2005-06-17 21:48:29.000000000 +0200
| +++ linux-2.6.13-rc2-ws/crypto/proc.c    2005-07-06 15:22:04.000000000 +0200
| @@ -7,7 +7,7 @@
|   *
|   * This program is free software; you can redistribute it and/or modify it
|   * under the terms of the GNU General Public License as published by 
| the Free
| - * Software Foundation; either version 2 of the License, or (at your 
| option)
| + * Software Foundation; either version 2 of the License, or (at your 
| option)
|   * any later version.
|   *
|   */
| @@ -94,7 +94,7 @@ static int crypto_info_open(struct inode
|  {
|      return seq_open(file, &crypto_seq_ops);
|  }
| -       
| +
|  static struct file_operations proc_crypto_ops = {
|      .open        = crypto_info_open,
|      .read        = seq_read,
| diff -uprN -X linux-2.6.13-rc2/Documentation/dontdiff 
| linux-2.6.13-rc2/crypto/serpent.c linux-2.6.13-rc2-ws/crypto/serpent.c
| --- linux-2.6.13-rc2/crypto/serpent.c    2005-06-17 21:48:29.000000000 +0200
| +++ linux-2.6.13-rc2-ws/crypto/serpent.c    2005-07-06 
| 15:22:39.000000000 +0200
| @@ -500,11 +500,11 @@ static int tnepres_setkey(void *ctx, con
|          || (keylen > SERPENT_MAX_KEY_SIZE)) {
|          *flags |= CRYPTO_TFM_RES_BAD_KEY_LEN;
|          return -EINVAL;
| -    }
| +    }
|  
|      for (i = 0; i < keylen; ++i)
|          rev_key[keylen - i - 1] = key[i];
| -
| +
|      return serpent_setkey(ctx, rev_key, keylen, flags);
|  }
|  
| diff -uprN -X linux-2.6.13-rc2/Documentation/dontdiff 
| linux-2.6.13-rc2/crypto/sha1.c linux-2.6.13-rc2-ws/crypto/sha1.c
| --- linux-2.6.13-rc2/crypto/sha1.c    2005-06-17 21:48:29.000000000 +0200
| +++ linux-2.6.13-rc2-ws/crypto/sha1.c    2005-07-06 15:22:55.000000000 +0200
| @@ -93,7 +93,7 @@ static void sha1_final(void* ctx, u8 *ou
|      sha1_update(sctx, padding, padlen);
|  
|      /* Append length */
| -    sha1_update(sctx, bits, sizeof bits);
| +    sha1_update(sctx, bits, sizeof bits);
|  
|      /* Store state in digest */
|      for (i = j = 0; i < 5; i++, j += 4) {
| diff -uprN -X linux-2.6.13-rc2/Documentation/dontdiff 
| linux-2.6.13-rc2/crypto/sha256.c linux-2.6.13-rc2-ws/crypto/sha256.c
| --- linux-2.6.13-rc2/crypto/sha256.c    2005-06-17 21:48:29.000000000 +0200
| +++ linux-2.6.13-rc2-ws/crypto/sha256.c    2005-07-06 15:23:11.000000000 
| +0200
| @@ -12,7 +12,7 @@
|   *
|   * This program is free software; you can redistribute it and/or modify it
|   * under the terms of the GNU General Public License as published by 
| the Free
| - * Software Foundation; either version 2 of the License, or (at your 
| option)
| + * Software Foundation; either version 2 of the License, or (at your 
| option)
|   * any later version.
|   *
|   */
| @@ -79,7 +79,7 @@ static void sha256_transform(u32 *state,
|      /* now blend */
|      for (i = 16; i < 64; i++)
|          BLEND_OP(i, W);
| -   
| +
|      /* load the state into our registers */
|      a=state[0];  b=state[1];  c=state[2];  d=state[3];
|      e=state[4];  f=state[5];  g=state[6];  h=state[7];
| diff -uprN -X linux-2.6.13-rc2/Documentation/dontdiff 
| linux-2.6.13-rc2/crypto/sha512.c linux-2.6.13-rc2-ws/crypto/sha512.c
| --- linux-2.6.13-rc2/crypto/sha512.c    2005-06-17 21:48:29.000000000 +0200
| +++ linux-2.6.13-rc2-ws/crypto/sha512.c    2005-07-06 15:24:42.000000000 
| +0200
| @@ -129,9 +129,9 @@ sha512_transform(u64 *state, u64 *W, con
|          }
|  
|      /* load the state into our registers */
| -    a=state[0];   b=state[1];   c=state[2];   d=state[3]; 
| -    e=state[4];   f=state[5];   g=state[6];   h=state[7]; 
| - 
| +    a=state[0];   b=state[1];   c=state[2];   d=state[3];
| +    e=state[4];   f=state[5];   g=state[6];   h=state[7];
| +
|      /* now iterate */
|      for (i=0; i<80; i+=8) {
|          t1 = h + e1(e) + Ch(e,f,g) + sha512_K[i  ] + W[i  ];
| @@ -151,9 +151,9 @@ sha512_transform(u64 *state, u64 *W, con
|          t1 = a + e1(f) + Ch(f,g,h) + sha512_K[i+7] + W[i+7];
|          t2 = e0(b) + Maj(b,c,d);    e+=t1;    a=t1+t2;
|      }
| - 
| -    state[0] += a; state[1] += b; state[2] += c; state[3] += d; 
| -    state[4] += e; state[5] += f; state[6] += g; state[7] += h; 
| +
| +    state[0] += a; state[1] += b; state[2] += c; state[3] += d;
| +    state[4] += e; state[5] += f; state[6] += g; state[7] += h;
|  
|      /* erase our data */
|      a = b = c = d = e = f = g = h = t1 = t2 = 0;
| @@ -252,22 +252,22 @@ sha512_final(void *ctx, u8 *hash)
|      bits[15] = t; t>>=8;
|      bits[14] = t; t>>=8;
|      bits[13] = t; t>>=8;
| -    bits[12] = t;
| +    bits[12] = t;
|      t = sctx->count[1];
|      bits[11] = t; t>>=8;
|      bits[10] = t; t>>=8;
|      bits[9 ] = t; t>>=8;
| -    bits[8 ] = t;
| +    bits[8 ] = t;
|      t = sctx->count[2];
|      bits[7 ] = t; t>>=8;
|      bits[6 ] = t; t>>=8;
|      bits[5 ] = t; t>>=8;
| -    bits[4 ] = t;
| +    bits[4 ] = t;
|      t = sctx->count[3];
|      bits[3 ] = t; t>>=8;
|      bits[2 ] = t; t>>=8;
|      bits[1 ] = t; t>>=8;
| -    bits[0 ] = t;
| +    bits[0 ] = t;
|  
|      /* Pad out to 112 mod 128. */
|      index = (sctx->count[0] >> 3) & 0x7f;
| diff -uprN -X linux-2.6.13-rc2/Documentation/dontdiff 
| linux-2.6.13-rc2/crypto/tea.c linux-2.6.13-rc2-ws/crypto/tea.c
| --- linux-2.6.13-rc2/crypto/tea.c    2005-06-17 21:48:29.000000000 +0200
| +++ linux-2.6.13-rc2-ws/crypto/tea.c    2005-07-06 15:26:32.000000000 +0200
| @@ -1,9 +1,9 @@
| -/*
| +/*
|   * Cryptographic API.
|   *
|   * TEA and Xtended TEA Algorithms
|   *
| - * The TEA and Xtended TEA algorithms were developed by David Wheeler
| + * The TEA and Xtended TEA algorithms were developed by David Wheeler
|   * and Roger Needham at the Computer Laboratory of Cambridge University.
|   *
|   * Copyright (c) 2004 Aaron Grothe ajgrothe@yahoo.com
| @@ -44,7 +44,7 @@ struct xtea_ctx {
|  
|  static int tea_setkey(void *ctx_arg, const u8 *in_key,
|                         unsigned int key_len, u32 *flags)
| -{
| +{
|  
|      struct tea_ctx *ctx = ctx_arg;
|     
| @@ -59,12 +59,12 @@ static int tea_setkey(void *ctx_arg, con
|      ctx->KEY[2] = u32_in (in_key + 8);
|      ctx->KEY[3] = u32_in (in_key + 12);
|  
| -    return 0;
| +    return 0;
|  
|  }
|  
|  static void tea_encrypt(void *ctx_arg, u8 *dst, const u8 *src)
| -{
| +{
|      u32 y, z, n, sum = 0;
|      u32 k0, k1, k2, k3;
|  
| @@ -91,7 +91,7 @@ static void tea_encrypt(void *ctx_arg, u
|  }
|  
|  static void tea_decrypt(void *ctx_arg, u8 *dst, const u8 *src)
| -{
| +{
|      u32 y, z, n, sum;
|      u32 k0, k1, k2, k3;
|  
| @@ -122,7 +122,7 @@ static void tea_decrypt(void *ctx_arg, u
|  
|  static int xtea_setkey(void *ctx_arg, const u8 *in_key,
|                         unsigned int key_len, u32 *flags)
| -{
| +{
|  
|      struct xtea_ctx *ctx = ctx_arg;
|     
| @@ -137,12 +137,12 @@ static int xtea_setkey(void *ctx_arg, co
|      ctx->KEY[2] = u32_in (in_key + 8);
|      ctx->KEY[3] = u32_in (in_key + 12);
|  
| -    return 0;
| +    return 0;
|  
|  }
|  
|  static void xtea_encrypt(void *ctx_arg, u8 *dst, const u8 *src)
| -{
| +{
|  
|      u32 y, z, sum = 0;
|      u32 limit = XTEA_DELTA * XTEA_ROUNDS;
| @@ -153,9 +153,9 @@ static void xtea_encrypt(void *ctx_arg,
|      z = u32_in (src + 4);
|  
|      while (sum != limit) {
| -        y += (z << 4 ^ z >> 5) + (z ^ sum) + ctx->KEY[sum&3];
| +        y += (z << 4 ^ z >> 5) + (z ^ sum) + ctx->KEY[sum&3];
|          sum += XTEA_DELTA;
| -        z += (y << 4 ^ y >> 5) + (y ^ sum) + ctx->KEY[sum>>11 &3];
| +        z += (y << 4 ^ y >> 5) + (y ^ sum) + ctx->KEY[sum>>11 &3];
|      }
|     
|      u32_out (dst, y);
| @@ -164,7 +164,7 @@ static void xtea_encrypt(void *ctx_arg,
|  }
|  
|  static void xtea_decrypt(void *ctx_arg, u8 *dst, const u8 *src)
| -{
| +{
|  
|      u32 y, z, sum;
|      struct tea_ctx *ctx = ctx_arg;
| diff -uprN -X linux-2.6.13-rc2/Documentation/dontdiff 
| linux-2.6.13-rc2/crypto/tgr192.c linux-2.6.13-rc2-ws/crypto/tgr192.c
| --- linux-2.6.13-rc2/crypto/tgr192.c    2005-06-17 21:48:29.000000000 +0200
| +++ linux-2.6.13-rc2-ws/crypto/tgr192.c    2005-07-06 15:26:44.000000000 
| +0200
| @@ -12,7 +12,7 @@
|   * This version is derived from the GnuPG implementation and the
|   * Tiger-Perl interface written by Rafael Sevilla
|   *
| - * Adapted for Linux Kernel Crypto  by Aaron Grothe
| + * Adapted for Linux Kernel Crypto  by Aaron Grothe
|   * ajgrothe@yahoo.com, February 22, 2005
|   *
|   * This program is free software; you can redistribute it and/or modify
| diff -uprN -X linux-2.6.13-rc2/Documentation/dontdiff 
| linux-2.6.13-rc2/crypto/twofish.c linux-2.6.13-rc2-ws/crypto/twofish.c
| --- linux-2.6.13-rc2/crypto/twofish.c    2005-06-17 21:48:29.000000000 +0200
| +++ linux-2.6.13-rc2-ws/crypto/twofish.c    2005-07-06 
| 15:27:14.000000000 +0200
| @@ -9,7 +9,7 @@
|   * Ported to CryptoAPI by Colin Slater <hoho@tacomeat.net>
|   *
|   * The original author has disclaimed all copyright interest in this
| - * code and thus put it in the public domain. The subsequent authors
| + * code and thus put it in the public domain. The subsequent authors
|   * have put this under the GNU General Public License.
|   *
|   * This program is free software; you can redistribute it and/or modify
| @@ -21,7 +21,7 @@
|   * but WITHOUT ANY WARRANTY; without even the implied warranty of
|   * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
|   * GNU General Public License for more details.
| - *
| + *
|   * You should have received a copy of the GNU General Public License
|   * along with this program; if not, write to the Free Software
|   * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
| @@ -839,7 +839,7 @@ static void twofish_encrypt(void *cx, u8
|  static void twofish_decrypt(void *cx, u8 *out, const u8 *in)
|  {
|      struct twofish_ctx *ctx = cx;
| - 
| +
|      /* The four 32-bit chunks of the text. */
|      u32 a, b, c, d;
|     
| diff -uprN -X linux-2.6.13-rc2/Documentation/dontdiff 
| linux-2.6.13-rc2/init/do_mounts.c linux-2.6.13-rc2-ws/init/do_mounts.c
| --- linux-2.6.13-rc2/init/do_mounts.c    2005-06-17 21:48:29.000000000 +0200
| +++ linux-2.6.13-rc2-ws/init/do_mounts.c    2005-07-06 
| 15:06:36.000000000 +0200
| @@ -277,7 +277,7 @@ static int __init do_mount_root(char *na
|      ROOT_DEV = current->fs->pwdmnt->mnt_sb->s_dev;
|      printk("VFS: Mounted root (%s filesystem)%s.\n",
|             current->fs->pwdmnt->mnt_sb->s_type->name,
| -           current->fs->pwdmnt->mnt_sb->s_flags & MS_RDONLY ?
| +           current->fs->pwdmnt->mnt_sb->s_flags & MS_RDONLY ?
|             " readonly" : "");
|      return 0;
|  }
| @@ -316,7 +316,7 @@ retry:
|  out:
|      putname(fs_names);
|  }
| -
| +
|  #ifdef CONFIG_ROOT_NFS
|  static int __init mount_nfs_root(void)
|  {
| diff -uprN -X linux-2.6.13-rc2/Documentation/dontdiff 
| linux-2.6.13-rc2/init/do_mounts_rd.c linux-2.6.13-rc2-ws/init/do_mounts_rd.c
| --- linux-2.6.13-rc2/init/do_mounts_rd.c    2005-06-17 
| 21:48:29.000000000 +0200
| +++ linux-2.6.13-rc2-ws/init/do_mounts_rd.c    2005-07-06 
| 15:07:19.000000000 +0200
| @@ -45,7 +45,7 @@ static int __init crd_load(int in_fd, in
|   *    cramfs
|   *     gzip
|   */
| -static int __init
| +static int __init
|  identify_ramdisk_image(int fd, int start_block)
|  {
|      const int size = 512;
| @@ -369,7 +369,7 @@ static void __init flush_window(void)
|      ulg c = crc;         /* temporary variable */
|      unsigned n, written;
|      uch *in, ch;
| -   
| +
|      written = sys_write(crd_outfd, window, outcnt);
|      if (written != outcnt && unzip_error == 0) {
|      printk(KERN_ERR "RAMDISK: incomplete write (%d != %d) %ld\n",
| diff -uprN -X linux-2.6.13-rc2/Documentation/dontdiff 
| linux-2.6.13-rc2/init/main.c linux-2.6.13-rc2-ws/init/main.c
| --- linux-2.6.13-rc2/init/main.c    2005-07-06 15:11:29.000000000 +0200
| +++ linux-2.6.13-rc2-ws/init/main.c    2005-07-06 15:08:27.000000000 +0200
| @@ -6,7 +6,7 @@
|   *  GK 2/5/95  -  Changed to support mounting root fs via NFS
|   *  Added initrd & change_root: Werner Almesberger & Hans Lermen, Feb '96
|   *  Moan early if gcc is old, avoiding bogus kernels - Paul Gortmaker, 
| May '96
| - *  Simplified starting of init:  Michael A. Griffith <grif@acm.org>
| + *  Simplified starting of init:  Michael A. Griffith <grif@acm.org>
|   */
|  
|  #define __KERNEL_SYSCALLS__
| @@ -391,7 +391,7 @@ static void noinline rest_init(void)
|      schedule();
|  
|      cpu_idle();
| -}
| +}
|  
|  /* Check for early params. */
|  static int __init do_early_param(char *param, char *val)
| @@ -600,7 +600,7 @@ static void __init do_basic_setup(void)
|      sysctl_init();
|  #endif
|  
| -    /* Networking initialization needs a process context */
| +    /* Networking initialization needs a process context */
|      sock_init();
|  
|      do_initcalls();
| @@ -705,7 +705,7 @@ static int init(void * unused)
|      /*
|       * We try each of these until one succeeds.
|       *
| -     * The Bourne shell can be used instead of init if we are
| +     * The Bourne shell can be used instead of init if we are
|       * trying to recover a really broken machine.
|       */
|  
| 
| -

---
~Randy
