Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750746AbWFEIYa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750746AbWFEIYa (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 04:24:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbWFEIY3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 04:24:29 -0400
Received: from wx-out-0102.google.com ([66.249.82.198]:1637 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750751AbWFEIY2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 04:24:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=e1seAL0RrES+i3GcLt7+UJqhe0Dz3UCIDn7DLwal8gAk4byZL1cmcsxuxCB01OCuGefJ6Z8ssxLwHjLBWJRYxJxxfJ9s+trV+SsTIkoDOJStfAx6rtJnpniQbTea6iz4w+VWJ2BlZBaYAk6iUIWgajHjbPSi8Msm8cvZny2XPm4=
Message-ID: <a44ae5cd0606050124h4c82f45aq27f68f9d07956642@mail.gmail.com>
Date: Mon, 5 Jun 2006 01:24:27 -0700
From: "Miles Lane" <miles.lane@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: 2.6.17-rc5-mm3 -- ACPI errors (are these ones that are significant?)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

During boot:

acpi_processor-0731 [00] processor_preregister_: Error while parsing
_PSD domain information. Assuming no coordination

During resume and after the "BUG: sleeping function called from
invalid context at include/asm/semaphore.h:99 in_atomic():0,
irqs_disabled():1" that I reported earlier:

PM: Finishing wakeup.
 acpi: resuming
ACPI: read EC, IB not empty
ACPI: read EC, OB not full
ACPI Exception (evregion-0412): AE_TIME, Returned by Handler for
[EmbeddedControl] [20060310]
ACPI Exception (dswexec-0459): AE_TIME, While resolving operands for
[Store] [20060310]
ACPI Error (psparse-0522): Method parse/execution failed
[\_TZ_.THRM._TMP] (Node c189ec44), AE_TIME
agpgart-intel 0000:00:00.0: resuming
