Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751554AbVKBKgz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751554AbVKBKgz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 05:36:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751556AbVKBKgz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 05:36:55 -0500
Received: from nproxy.gmail.com ([64.233.182.197]:13743 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751554AbVKBKgz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 05:36:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=nALgQjjTpJkAagDHTY62qGcLaYpC9QwBBPa2yEniih5ntE3/oHm2TkJxHezulPbxuEikPxMlp3XLWcnhZFfWvO0ZRvGtjVTO7q3NTAbpQjFkMVQuL5kri2Bo7Cqdd8zOIsYE9nv+2qkAanOTomzix0/wK2u/d3hRR8pBjv3JBG4=
Message-ID: <6278d2220511020236l26f74eecp11910e59fd1c432d@mail.gmail.com>
Date: Wed, 2 Nov 2005 10:36:54 +0000
From: Daniel J Blueman <daniel.blueman@gmail.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: cpuset - question
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Janos,

You can see what valid memory nodes are available from the top-level
cpuset directory:

# cat /dev/cpuset/mems
0 1 2 3

If you were to be running on a NUMA-capable system, you'd also want to
ensure page interleaving was disabled in the BIOS/pre-boot firmware
too.
___
Daniel J Blueman
