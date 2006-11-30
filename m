Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759021AbWK3Eof@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759021AbWK3Eof (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 23:44:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759025AbWK3Eof
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 23:44:35 -0500
Received: from web56507.mail.re3.yahoo.com ([66.196.97.36]:1691 "HELO
	web56507.mail.re3.yahoo.com") by vger.kernel.org with SMTP
	id S1759021AbWK3Eoe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 23:44:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=Dfgpzo2cHLkdBvjOPe+kRi8idZWb0TS2++fe1R9DJOiykqxSkKK2mNdxYuLYlx73i7/61thr3/lb0aByn/2LQ+TS2cJ8sfAzmP+hJLT23DgL0E/2MBgS8GcmGmLX2XfttDUFXy0KQCFiQwAxbOzxIYUIlbE7eg/zogIySqBbUrY=;
X-YMail-OSG: BV5pdV0VM1nkVBkCoSSQtub7zen9hywEH2.bs09guHcz6dRSCYSRFCZx105UnOJGseACJERRwHPtpGvoPNcQJhSFNuRIMkT22N9arvK6b98Lhn1eGzFUQw--
Date: Wed, 29 Nov 2006 20:44:33 -0800 (PST)
From: linux err <linux_err@yahoo.com>
Subject: Core file size?
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <4288.39070.qm@web56507.mail.re3.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Does anyone know what determines the size of a core
dump? I have a process running out of memory (it
allocates about 3GB) - but the size of core varies
(between 2-3GB) depending on how much the process
wrote on the allocated memory.

Also, the time it takes to write the core (same size)
varies??

I briefly looked at elf_core_dump and get_user_pages()
in binfmt_elf.c. Is there any documentation on this?
Or anyone knows how it works?

TIA


 
____________________________________________________________________________________
Cheap talk?
Check out Yahoo! Messenger's low PC-to-Phone call rates.
http://voice.yahoo.com
