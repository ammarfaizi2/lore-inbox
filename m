Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264973AbUGGI3D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264973AbUGGI3D (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 04:29:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264980AbUGGI3D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 04:29:03 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:44243 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id S264973AbUGGI3B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 04:29:01 -0400
Message-ID: <40EBB444.6020309@t-online.de>
Date: Wed, 07 Jul 2004 10:28:52 +0200
From: "Harald Dunkel" <harald.dunkel@t-online.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML Mailinglist <linux-kernel@vger.kernel.org>
Subject: asm-x86_64/bitops.h: problem with long vs int?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-ID: Z2PXPrZGweScs0pklMsEQAGz6fbLhKO+qdm90jcqiYhdk8Us6UR56B
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

Maybe its just a cosmetic problem, but the definitions
for set_bit() and clear_bit() in asm-x86_64/bitops.h
look a little bit asymmetrical:

static __inline__ void set_bit(long nr, volatile void * addr)
static __inline__ void clear_bit(int nr, volatile void * addr)


Regards

Harri
