Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264888AbSJ3UWb>; Wed, 30 Oct 2002 15:22:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264882AbSJ3UWb>; Wed, 30 Oct 2002 15:22:31 -0500
Received: from 3-090.ctame701-1.telepar.net.br ([200.193.161.90]:2280 "EHLO
	3-090.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S264883AbSJ3UV5>; Wed, 30 Oct 2002 15:21:57 -0500
Date: Wed, 30 Oct 2002 18:28:02 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: "Matthew J. Fanto" <mattf@mattjf.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: The Ext3sj Filesystem
In-Reply-To: <200210301434.17901.mattf@mattjf.com>
Message-ID: <Pine.LNX.4.44L.0210301826410.1697-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Oct 2002, Matthew J. Fanto wrote:

> I am annoucing the development of the ext3sj filesystem. Ext3sj is a new
> encrypted filesystem based off ext3. Ext3sj is an improvement over the
> current loopback solution because we do not in fact require a loopback
> device.  [snip]  Instead, every file is encrypted seperately

Very nice, for exactly the reasons you outlined ;)

> Currently, ext3sj supports the following algorithms: AES, 3DES, Twofish,
> Serpent, RC6, RC5, RC2, Blowfish, CAST-256, XTea, Safer+, SHA1, SHA256,
> SHA384, SHA512, MD5, with more to come.  If anyone has any comments,

How about using the algorithms that are already in the kernel
via the crypto API so all of the kernel can share the same
crypto algorithms ?

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://distro.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>

