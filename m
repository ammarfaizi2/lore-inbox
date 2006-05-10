Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751291AbWEJA3V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751291AbWEJA3V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 20:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751338AbWEJA3U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 20:29:20 -0400
Received: from smtpq2.groni1.gr.home.nl ([213.51.130.201]:60379 "EHLO
	smtpq2.groni1.gr.home.nl") by vger.kernel.org with ESMTP
	id S1751291AbWEJA3U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 20:29:20 -0400
Message-ID: <4461341B.7050602@keyaccess.nl>
Date: Wed, 10 May 2006 02:30:19 +0200
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.17-rc3 -- SMP alternatives: switching to UP code
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi list.

I just noticed this in the 2.6.17-rc3 dmesg:

===
Checking 'hlt' instruction... OK.
SMP alternatives: switching to UP code
Freeing SMP alternatives: 0k freed
ACPI: setting ELCR to 0400 (from 1608)
===

Should I be seeing this "SMP alternatives" thing on a !CONFIG_SMP 
kernel? It does say 0k, but something is apparently being done at 
runtime still. Why?

Rene.
