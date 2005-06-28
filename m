Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261391AbVF1MA4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261391AbVF1MA4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 08:00:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261402AbVF1MA4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 08:00:56 -0400
Received: from mailhub3.nextra.sk ([195.168.1.146]:41991 "EHLO
	mailhub3.nextra.sk") by vger.kernel.org with ESMTP id S261391AbVF1MAw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 08:00:52 -0400
Message-ID: <42C13BF1.1040904@rainbow-software.org>
Date: Tue, 28 Jun 2005 14:00:49 +0200
From: Ondrej Zary <linux@rainbow-software.org>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Booting uncompressed kernel image on i386?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there an easy way to boot uncompressed kernel (2.6) image instead of 
the compressed one (bzImage) - using e.g. LILO?
I'm trying to do that because the decompression takes about 15 seconds 
on my i386 (it's really an i386 - i386DX/25 :-) The uncompressed kernel 
is about 1.5MB. I've already tried compressing it using gzip -1 instead 
of gzip -9 but that didn't make decompression any faster.


-- 
Ondrej Zary
