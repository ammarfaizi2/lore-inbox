Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263374AbRFEVXy>; Tue, 5 Jun 2001 17:23:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263372AbRFEVXo>; Tue, 5 Jun 2001 17:23:44 -0400
Received: from smtp4.vol.cz ([195.250.128.84]:45067 "EHLO smtp4.vol.cz")
	by vger.kernel.org with ESMTP id <S263366AbRFEVXj>;
	Tue, 5 Jun 2001 17:23:39 -0400
Date: Tue, 5 Jun 2001 23:23:38 +0200 (CEST)
Message-Id: <200106052123.f55LNcb01427@smtp4.vol.cz>
Content-Type: text/plain; charset=windows-1250
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0
X-Mailer: Perl5 Mail::Internet v1.32
To: linux-kernel@vger.kernel.org
Reply-To: tomas.f@volny.cz
From: tomas.f@volny.cz
Cc: ibgt@gmx.de
Subject: HP scanner SCSI card with 53c400a
X-HTTP-Posting-Host: 195.122.206.219
X-HTTP-Posting-User: tomas.f
X-HTTP-Script-Name: /cgi-perl/NVM/cgi-bin/NVM.pl.CZ.cgi
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I have an old SCSI card that came with old HP scanner. It contains NCR 53c400a chip, one 3pin jumper and some PAL logics. I tried
modprobe g_NCR5380 ncr_53c400a=1 ncr_addr=0x280 ncr_irq=255 as described in kernel docs, and it writes No device always.
It works fine at address 0x280 under Winslows. Is there a chance to make it working under Linux 2.4.x?

Tomas

