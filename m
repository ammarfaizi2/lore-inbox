Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266186AbTAILS1>; Thu, 9 Jan 2003 06:18:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266210AbTAILS1>; Thu, 9 Jan 2003 06:18:27 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:5136 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266186AbTAILS0>; Thu, 9 Jan 2003 06:18:26 -0500
Date: Thu, 9 Jan 2003 11:26:59 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>
Subject: __gpl_ksymtab
Message-ID: <20030109112659.B15310@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	Rusty Russell <rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.5.55, we have a new section called "__gpl_ksymtab".

This, unfortunately, isn't mentioned in the linker script, and on ARM
gets placed at 0x1c58, where the rest of the kernel is at 0xcXXXXXXX.

This section isn't even mentioned in the x86 linker script, so there
isn't an example of the placement expectations of this section.

Rusty, can you provide the missing bits please?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

