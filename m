Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265051AbUJLMYs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265051AbUJLMYs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 08:24:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266181AbUJLMYs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 08:24:48 -0400
Received: from mail.vc-graz.ac.at ([193.171.121.30]:37607 "EHLO
	proxy.vc-graz.ac.at") by vger.kernel.org with ESMTP id S265051AbUJLMYq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 08:24:46 -0400
From: Wolfgang Scheicher <worf@sbox.tu-graz.ac.at>
To: linux-kernel@vger.kernel.org
Subject: 2.6.9-rc4 USB storage problems
Date: Tue, 12 Oct 2004 14:24:59 +0200
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410121424.59584.worf@sbox.tu-graz.ac.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm sorry for not being able to track down the issue better:

if i mount my usb-stick ( Sandisk Micro 256MB, USB2.0, FAT ), write a file 
(for example 4MB) to it and unmount or sync, then there is a lot of activity 
on the stick, but the unmount or sync doesn't finish ( waited > 10 Minutes - 
should not take more than 1-2 sec ).

2.6.9-rc2 seems to be the same issue
i remember 2.6.7 and before being fine for my usb-stick, 2.6.8(.x) i need to 
test...

oh - and it _is_ detected as high speed USB device - and eaven if it would 
have been usb 1.x it shouldn't take that long.

any hints? any patches i shall try?

Worf
