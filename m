Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129468AbQKPARp>; Wed, 15 Nov 2000 19:17:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129437AbQKPARg>; Wed, 15 Nov 2000 19:17:36 -0500
Received: from mx1.port.ru ([194.67.23.32]:9481 "EHLO mx1.port.ru")
	by vger.kernel.org with ESMTP id <S129136AbQKPARS>;
	Wed, 15 Nov 2000 19:17:18 -0500
From: "Samium Gromoff" <_deepfire@mail.ru>
To: linux-kernel@vger.kernel.org
Cc: guus@warande3094.warande.uu.nl
Subject: Re: (iptables) ip_conntrack bug?
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: [195.34.30.76]
Reply-To: "Samium Gromoff" <_deepfire@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E13wCGq-0004xL-00@f6.mail.ru>
Date: Thu, 16 Nov 2000 02:47:16 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

vegae:/usr/src/linux# grep -r ./* --regexp="IPS_CON" | grep "define"
./include/linux/elf.h:#define DT_MIPS_CONFLICT  0x70000008
./include/linux/elf.h:#define DT_MIPS_CONFLICTNO        0x7000000b
./include/linux/elf.h:#define SHT_MIPS_CONFLICT 0x70000002
vegae:/usr/src/linux#                                        
   hmmm... looks like theriz no IPS_CONFIRMED
  definition in test9...

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
