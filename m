Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263690AbTDNSUs (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 14:20:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263635AbTDNSUr (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 14:20:47 -0400
Received: from pizda.ninka.net ([216.101.162.242]:54245 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263633AbTDNSQF (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 14:16:05 -0400
Date: Mon, 14 Apr 2003 11:20:49 -0700 (PDT)
Message-Id: <20030414.112049.05124201.davem@redhat.com>
To: yoshfuji@linux-ipv6.org
Cc: kuznet@ms2.inr.ac.ru, netdev@oss.sgi.com, linux-kernel@vger.kernel.org,
       usagi@linux-ipv6.org
Subject: Re: [PATCH] [IPV6] Fixed multiple mistake extension header handling
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030415.032109.127483264.yoshfuji@linux-ipv6.org>
References: <20030415.032109.127483264.yoshfuji@linux-ipv6.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: YOSHIFUJI Hideaki / 吉藤英明 <yoshfuji@linux-ipv6.org>
   Date: Tue, 15 Apr 2003 03:21:09 +0900 (JST)

    - double free if sending Parameter Problem message in reassembly code.
    - (sometimes) broken checksum
    - HbH not producing unknown header; it is only allowed at the beginning of
      the exthdrs chain.
    - wrong pointer value in Parameter Problem message.
   
   I've fixed the problem.
   
   Patch is against 2.5.67 + CS 1.1202.

Patch applied, thank you very much.
