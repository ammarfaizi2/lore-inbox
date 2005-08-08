Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750827AbVHHLmB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750827AbVHHLmB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 07:42:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750828AbVHHLmB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 07:42:01 -0400
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35]:2641 "HELO
	smtp004.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1750827AbVHHLmA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 07:42:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Received:From:To:Subject:Date:User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=sVk7qxZ66SZpjKJThMNkkkgkGKyCc0anUbAbJVq/8ecoepbpcuH/kM+qOniNvhMvWtN9htZkFnLDtlPRj3ttbKN2Jm2PmN37y5yoXyXfo9TaY/aYG0HqLbw5F4w80BWP8ezAretvMjI91C4JSzI7AWJyZ4MdmDHUO0xp+uwB/1Q=  ;
From: Karsten Wiese <annabellesgarden@yahoo.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Typofix_i82559_to_i8259
Date: Mon, 8 Aug 2005 13:41:41 +0200
User-Agent: KMail/1.8.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508081341.41409.annabellesgarden@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The legacy PIC's name is "i8259".

Signed-off-by: Karsten Wiese <annabellesgarden@yahoo.de>


diff -upr linux-2.6.13-rc6/arch/i386/kernel/io_apic.c linux-2.6.13/arch/i386/kernel/io_apic.c
--- linux-2.6.13-rc6/arch/i386/kernel/io_apic.c	2005-08-08 11:46:00.000000000 +0200
+++ linux-2.6.13/arch/i386/kernel/io_apic.c	2005-08-08 13:24:52.000000000 +0200
@@ -1641,9 +1641,9 @@ void disable_IO_APIC(void)
 	clear_IO_APIC();
 
 	/*
-	 * If the i82559 is routed through an IOAPIC
+	 * If the i8259 is routed through an IOAPIC
 	 * Put that IOAPIC in virtual wire mode
-	 * so legacy interrups can be delivered.
+	 * so legacy interrupts can be delivered.
 	 */
 	pin = find_isa_irq_pin(0, mp_ExtINT);
 	if (pin != -1) {
diff -upr linux-2.6.13-rc6/arch/x86_64/kernel/io_apic.c linux-2.6.13/arch/x86_64/kernel/io_apic.c
--- linux-2.6.13-rc6/arch/x86_64/kernel/io_apic.c	2005-08-08 11:46:01.000000000 +0200
+++ linux-2.6.13/arch/x86_64/kernel/io_apic.c	2005-08-08 13:25:09.000000000 +0200
@@ -1138,9 +1138,9 @@ void disable_IO_APIC(void)
 	clear_IO_APIC();
 
 	/*
-	 * If the i82559 is routed through an IOAPIC
+	 * If the i8259 is routed through an IOAPIC
 	 * Put that IOAPIC in virtual wire mode
-	 * so legacy interrups can be delivered.
+	 * so legacy interrupts can be delivered.
 	 */
 	pin = find_isa_irq_pin(0, mp_ExtINT);
 	if (pin != -1) {

	

	
		
___________________________________________________________ 
Gesendet von Yahoo! Mail - Jetzt mit 1GB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de
