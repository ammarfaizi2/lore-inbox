Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261691AbVADPb4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261691AbVADPb4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 10:31:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261690AbVADPaG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 10:30:06 -0500
Received: from fyrebird.net ([217.70.144.192]:4514 "HELO fyrebird.net")
	by vger.kernel.org with SMTP id S261684AbVADP3t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 10:29:49 -0500
X-Qmail-Scanner-Mail-From: lethalman@fyrebird.net via fyrebird
X-Qmail-Scanner: 1.23 (Clear:RC:0(62.11.81.88):. Processed in 1.935503 secs)
Message-ID: <41DAB3AA.4010207@fyrebird.net>
Date: Tue, 04 Jan 2005 16:18:02 +0100
From: Lethalman <lethalman@fyrebird.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Let me know EIP address
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to get the EIP value from a simple program in C but i don't 
how to do it. I need it to know the current address position on the code 
segment.

main() {
   long *eip;
   asm("mov %%eip,%0" : "=g"(eip));
   printf("%p\n", eip);
}

Unfortunately EIP is not that kind of register :P
Does anyone know how to get EIP?

-- 
www.iosn.it * Amministratore Italian Open Source Network
www.fyrebird.net * Fyrebird Hosting Provider - Technical Department
