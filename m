Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268060AbUH3Oac@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268060AbUH3Oac (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 10:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268176AbUH3Oac
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 10:30:32 -0400
Received: from mailer.nec-labs.com ([138.15.108.3]:5978 "EHLO
	mailer.nec-labs.com") by vger.kernel.org with ESMTP id S268060AbUH3Oa0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 10:30:26 -0400
Message-ID: <41333A0C.5090102@nec-labs.com>
Date: Mon, 30 Aug 2004 10:30:36 -0400
From: Lei Yang <leiyang@nec-labs.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>,
       Kernel Newbies Mailing List <kernelnewbies@nl.linux.org>
Subject: Kernel module problem: no version for "struct_module" found
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Aug 2004 14:30:26.0275 (UTC) FILETIME=[E432A330:01C48E9D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi friends,

Have been working on a simple kernel module, I've made everything built 
with kbuild and insmod test.ko. Now it seems that the module has been 
installed, however, it doesn't seem to work correctly. I get this dmesg:

kernel: test: no version for "struct_module" found: kernel tainted.

Experts here - what is struct_module and how to make modules give proper 
version for it?

TIA
