Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281070AbRKTOVA>; Tue, 20 Nov 2001 09:21:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281069AbRKTOUu>; Tue, 20 Nov 2001 09:20:50 -0500
Received: from www.security.wayne.edu ([141.217.2.10]:9663 "EHLO
	security.wayne.edu") by vger.kernel.org with ESMTP
	id <S280872AbRKTOUj>; Tue, 20 Nov 2001 09:20:39 -0500
Message-Id: <200111201410.fAKEACH21020@security.wayne.edu>
Content-Type: text/plain;
  charset="us-ascii"
From: "Nathan W. Labadie" <ab0781@wayne.edu>
Organization: Wayne State University
To: linux-kernel@vger.kernel.org
Subject: problems with drivers/char/char.o
Date: Tue, 20 Nov 2001 09:20:32 -0500
X-Mailer: KMail [version 1.3.2]
X-gpg-key: http://ucomm.wayne.edu/~nate/gpg_key.asc
X-gpg-fingerprint: FB19 5F58 9CF2 8E8C E221 5603 9D75 0FB3 06C0 1952
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When compiling 2.4.15-pre7, I get the following error:

--- snip ---
/usr/src/linux/arch/i386/lib/lib.a \
        --end-group \
        -o vmlinux
drivers/char/char.o: In function `setup_serial_acpi':
drivers/char/char.o(.text.init+0x109b): undefined reference to 
`early_serial_setup'
--- snip ---

This seems to be directly related to the option CONFIG_SERIAL_ACPI. 
Disabling CONFIG_SERIAL_ACPI seems to correct the problem as a 
temporary solution. I can provide my config if necessary.

Thanks and keep up the good work,
Nate

-- 
Nathan W. Labadie       | ab0781@wayne.edu	
Sr. Security Specialist | 313/577.2126
Wayne State University  | 313/577.5626 fax
C&IT Security Office: http://security.wayne.edu

