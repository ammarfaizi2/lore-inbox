Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263637AbTGTOii (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 10:38:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267205AbTGTOii
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 10:38:38 -0400
Received: from mailserver3.hrz.tu-darmstadt.de ([130.83.126.47]:35076 "EHLO
	mailserver3.hrz.tu-darmstadt.de") by vger.kernel.org with ESMTP
	id S263637AbTGTOih (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 10:38:37 -0400
Message-ID: <3F1AAB4A.80201@hrzpub.tu-darmstadt.de>
Date: Sun, 20 Jul 2003 16:46:34 +0200
From: Ruediger Scholz <rscholz@hrzpub.tu-darmstadt.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de-AT; rv:1.4) Gecko/20030624
X-Accept-Language: de-de, de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ALSA causes APIC Error on 2.6.0-test1
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

as mentioned early on this list 
(http://marc.theaimsgroup.com/?l=linux-kernel&m=105861457807306&w=2) I 
tried to run kernel-2.6.0-test1 with enabled IO-APIC on my P4/2.66 GHz 
with an SIS645DX-Chipset. It booted quite well, but I recognize several 
APIC Errors in "dmesg".
I tested the kernel a little bit, and when I played music the message 
"APIC Error on CPU0 40(40)" appears a lot of times in the system.log. I 
stopped the music and no further "APIC Error on CPU0 40(40)" -message 
was written into system's log.

So I think the culprit for the error is ALSA-soundsystem. I use the 
intel_8x0 driver for the built-in SIS7012 AC'97 Codec.
Has anyone seen the same behaviour, or knows how to stop this error?

TIA,
    Ruediger

