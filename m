Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279732AbRJ3BjV>; Mon, 29 Oct 2001 20:39:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279731AbRJ3BjJ>; Mon, 29 Oct 2001 20:39:09 -0500
Received: from islay.mach.uni-karlsruhe.de ([129.13.162.92]:32412 "EHLO
	mailout.plan9.de") by vger.kernel.org with ESMTP id <S279730AbRJ3Biy>;
	Mon, 29 Oct 2001 20:38:54 -0500
Date: Tue, 30 Oct 2001 02:39:33 +0100
From: <pcg@goof.com ( Marc) (A.) (Lehmann )>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.13-ac5 && vtun not working
Message-ID: <20011030023933.A11774@schmorp.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20011030021740.A8708@schmorp.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20011030021740.A8708@schmorp.de>
X-Operating-System: Linux version 2.4.8-ac9 (root@cerebro) (gcc version 3.0.1) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2001 at 02:17:40AM +0100, " Marc A. Lehmann " <pcg@goof.com> wrote:
> a _lot_ of searching revealed this code fragment:

In my usual attempt to generate more traffic, I forgot to mention that I
found it in net/core/dev.c ;)

(oh, and after reading the comments int hat file, I think that maybe tun.c
simply shouldn't call dev_alloc_name...)

-- 
      -----==-                                             |
      ----==-- _                                           |
      ---==---(_)__  __ ____  __       Marc Lehmann      +--
      --==---/ / _ \/ // /\ \/ /       pcg@goof.com      |e|
      -=====/_/_//_/\_,_/ /_/\_\       XX11-RIPE         --+
    The choice of a GNU generation                       |
                                                         |
