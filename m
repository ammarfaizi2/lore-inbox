Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263975AbTEGPOM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 11:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263998AbTEGPOM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 11:14:12 -0400
Received: from www.tammen.de ([62.225.14.106]:22533 "EHLO mail.tammen.de")
	by vger.kernel.org with ESMTP id S263975AbTEGPMY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 11:12:24 -0400
From: Heinz Ulrich Stille <hus@design-d.de>
Organization: design_d gmbh
To: linux-kernel@vger.kernel.org
Subject: Re: Tyan Tiger MP + 2.4.20
Date: Wed, 7 May 2003 17:24:48 +0200
User-Agent: KMail/1.5
References: <S263086AbTEGLmI/20030507114208Z+5636@vger.kernel.org>
In-Reply-To: <S263086AbTEGLmI/20030507114208Z+5636@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200305071724.48061.hus@design-d.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 07 May 2003 13:42, Steve Spencer wrote:
> Has anyone else experiencesd stability issues with 2.4.20 and Tyan Tiger MP
> mobo/Athlon MP processors?

I've had only two problems with my Tiger MP and 2.4.20:
- Set "CONFIG_AMD_PM768" to "n", with "y" the system will freeze somewhere in
the boot process;
- if you use Athlon XPs, make sure the L5 bridge is really securely connected.
Oh, and don't use too much unregistered ram...

Apart from that I've never had any issues. As the first touches power
management, it might be relevant.

Are your problems with rebooting only? Do you have ACPI enabled? I've ACPI
enabled and APM disabled (shouldn't work on SMP anyway).

MfG, Ulrich

-- 
Heinz Ulrich Stille / Tel.: +49-541-9400463 / Fax: +49-541-9400450
design_d gmbh / Lortzingstr. 2 / 49074 Osnabrück / www.design-d.de

