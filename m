Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268779AbUIHABY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268779AbUIHABY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 20:01:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268781AbUIHABY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 20:01:24 -0400
Received: from hulk.vianw.pt ([195.22.31.43]:36258 "EHLO hulk.vianw.pt")
	by vger.kernel.org with ESMTP id S268779AbUIHABA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 20:01:00 -0400
Message-ID: <413E4A7D.8010401@esoterica.pt>
Date: Wed, 08 Sep 2004 00:55:41 +0100
From: Paulo da Silva <psdasilva@esoterica.pt>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040821
X-Accept-Language: pt, pt-br
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: NETWORK broken at least for 2.6.8.1 and 2.6.9-rc1
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:

For almost all sites I cannot download using wget or ftp for example.
I can comunicate between two PCs using ssh and rsync however.
ping and traceroute also work fine.
I discovered this problem because I was unable to fetch any
file when using "emerge -f".
I tried with k 2.6.7 with exactly the same configuration and it works!

I am using gentoo in a laptop Compaq presario 2541EA.
The module is natsemi.c. I tried to copy this file from 2.6.7 into
2.6.9-rc1 and recompile the kernel without any success.
The problem still remains.
If any further information is need, pls. email me.
Thank you.
______________________________________________________
Here is an example of what happens:
# wget www.esoterica.pt
--00:05:44--  http://www.esoterica.pt/
           => `index.html'
Resolving www.esoterica.pt... 195.22.31.35
Connecting to www.esoterica.pt[195.22.31.35]:80... connected.
HTTP request sent, awaiting response...

It stops forever here!!!

For very few sites (cnn.com for example) it works:
# wget www.cnn.com
--00:10:12--  http://www.cnn.com/
          => `index.html'
Resolving www.cnn.com... 64.236.16.52, 64.236.16.84, 64.236.16.116, ...
Connecting to www.cnn.com[64.236.16.52]:80... connected.
HTTP request sent, awaiting response... 200 OK
Length: unspecified [text/html]

   [         <=>                                ] 60,725        22.24K/s

00:10:19 (22.19 KB/s) - `index.html' saved [60725]

