Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030453AbWADWAv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030453AbWADWAv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 17:00:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030468AbWADWAv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 17:00:51 -0500
Received: from a34-mta01.direcpc.com ([66.82.4.90]:39156 "EHLO
	a34-mta01.direcway.com") by vger.kernel.org with ESMTP
	id S1030447AbWADWAt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 17:00:49 -0500
Date: Wed, 04 Jan 2006 17:00:25 -0500
From: Ben Collins <bcollins@ubuntu.com>
Subject: [PATCH 07/15] acpi: Add list of IBM R40 laptops to processor_power dmi
 table.
To: linux-kernel@vger.kernel.org
Message-id: <0ISL00NX49551L@a34-mta01.direcway.com>
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Ben Collins <bcollins@ubuntu.com>

---

 drivers/acpi/processor_idle.c |   67 +++++++++++++++++++++++++++++++----------
 1 files changed, 51 insertions(+), 16 deletions(-)

883292d0b65189123df24f335b5705f98da9a6ed
diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 807b0df..552420e 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -95,22 +95,57 @@ static int set_max_cstate(struct dmi_sys
 }
 
 static struct dmi_system_id __initdata processor_power_dmi_table[] = {
-	{set_max_cstate, "IBM ThinkPad R40e", {
-					       DMI_MATCH(DMI_BIOS_VENDOR,
-							 "IBM"),
-					       DMI_MATCH(DMI_BIOS_VERSION,
-							 "1SET60WW")},
-	 (void *)1},
-	{set_max_cstate, "Medion 41700", {
-					  DMI_MATCH(DMI_BIOS_VENDOR,
-						    "Phoenix Technologies LTD"),
-					  DMI_MATCH(DMI_BIOS_VERSION,
-						    "R01-A1J")}, (void *)1},
-	{set_max_cstate, "Clevo 5600D", {
-					 DMI_MATCH(DMI_BIOS_VENDOR,
-						   "Phoenix Technologies LTD"),
-					 DMI_MATCH(DMI_BIOS_VERSION,
-						   "SHE845M0.86C.0013.D.0302131307")},
+	{ set_max_cstate, "IBM ThinkPad R40e", {
+	  DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
+	  DMI_MATCH(DMI_BIOS_VERSION,"1SET60WW")}, (void *)1},
+	{ set_max_cstate, "IBM ThinkPad R40e", {
+	  DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
+	  DMI_MATCH(DMI_BIOS_VERSION,"1SET43WW") }, (void*)1},
+	{ set_max_cstate, "IBM ThinkPad R40e", {
+	  DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
+	  DMI_MATCH(DMI_BIOS_VERSION,"1SET45WW") }, (void*)1},
+	{ set_max_cstate, "IBM ThinkPad R40e", {
+	  DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
+	  DMI_MATCH(DMI_BIOS_VERSION,"1SET47WW") }, (void*)1},
+	{ set_max_cstate, "IBM ThinkPad R40e", {
+	  DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
+	  DMI_MATCH(DMI_BIOS_VERSION,"1SET50WW") }, (void*)1},
+	{ set_max_cstate, "IBM ThinkPad R40e", {
+	  DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
+	  DMI_MATCH(DMI_BIOS_VERSION,"1SET52WW") }, (void*)1},
+	{ set_max_cstate, "IBM ThinkPad R40e", {
+	  DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
+	  DMI_MATCH(DMI_BIOS_VERSION,"1SET55WW") }, (void*)1},
+	{ set_max_cstate, "IBM ThinkPad R40e", {
+	  DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
+	  DMI_MATCH(DMI_BIOS_VERSION,"1SET56WW") }, (void*)1},
+	{ set_max_cstate, "IBM ThinkPad R40e", {
+	  DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
+	  DMI_MATCH(DMI_BIOS_VERSION,"1SET59WW") }, (void*)1},
+	{ set_max_cstate, "IBM ThinkPad R40e", {
+	  DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
+	  DMI_MATCH(DMI_BIOS_VERSION,"1SET60WW") }, (void*)1},
+	{ set_max_cstate, "IBM ThinkPad R40e", {
+	  DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
+	  DMI_MATCH(DMI_BIOS_VERSION,"1SET61WW") }, (void*)1},
+	{ set_max_cstate, "IBM ThinkPad R40e", {
+	  DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
+	  DMI_MATCH(DMI_BIOS_VERSION,"1SET62WW") }, (void*)1},
+	{ set_max_cstate, "IBM ThinkPad R40e", {
+	  DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
+	  DMI_MATCH(DMI_BIOS_VERSION,"1SET64WW") }, (void*)1},
+	{ set_max_cstate, "IBM ThinkPad R40e", {
+	  DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
+	  DMI_MATCH(DMI_BIOS_VERSION,"1SET65WW") }, (void*)1},
+	{ set_max_cstate, "IBM ThinkPad R40e", {
+	  DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
+	  DMI_MATCH(DMI_BIOS_VERSION,"1SET68WW") }, (void*)1},
+	{ set_max_cstate, "Medion 41700", {
+	  DMI_MATCH(DMI_BIOS_VENDOR,"Phoenix Technologies LTD"),
+	  DMI_MATCH(DMI_BIOS_VERSION,"R01-A1J")}, (void *)1},
+	{ set_max_cstate, "Clevo 5600D", {
+	  DMI_MATCH(DMI_BIOS_VENDOR,"Phoenix Technologies LTD"),
+	  DMI_MATCH(DMI_BIOS_VERSION,"SHE845M0.86C.0013.D.0302131307")},
 	 (void *)2},
 	{},
 };
-- 
1.0.5
