Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262696AbSJLCFy>; Fri, 11 Oct 2002 22:05:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262702AbSJLCFx>; Fri, 11 Oct 2002 22:05:53 -0400
Received: from mail.storm.ca ([209.87.239.66]:6020 "EHLO mail.storm.ca")
	by vger.kernel.org with ESMTP id <S262696AbSJLCFx>;
	Fri, 11 Oct 2002 22:05:53 -0400
Message-ID: <3DA857AB.2010504@storm.ca>
Date: Sat, 12 Oct 2002 10:11:07 -0700
From: Sandy Harris <sandy@storm.ca>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mitsuru KANDA <mk@linux-ipv6.org>
CC: linux-kernel@vger.kernel.org, design@lists.freeswan.org,
       usagi@linux-ipv6.org
Subject: Re: [Design] [PATCH] USAGI IPsec
References: <m3k7kpjt7c.wl@karaba.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mitsuru KANDA wrote:

>Hello Linux kernel network maintainers,
>
>I'm a member of USAGI project.
>  
>
   [snip]

>2. Cipher/Digest Algorithms
>
>	Supported algorithms:
>		Ciphers: DES, 3DES and AES
>		Digests: MD5 and SHA1
>
>	We use CryptoAPI as cipher/digest algorithm.
>	- CryptoAPI
>		http://www.kerneli.org/
>  
>
Please remove DES as it is insecure. For discussion, see:
http://www.freeswan.org/freeswan_trees/freeswan-1.98b/doc/politics.html#desnotsecure

