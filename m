Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269237AbTGVTZQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 15:25:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270056AbTGVTZQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 15:25:16 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:52872 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S269237AbTGVTZG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 15:25:06 -0400
Message-ID: <F341E03C8ED6D311805E00902761278C0D2A2BE4@xfc04.fc.hp.com>
From: "MIYOSHI,DENNIS (HP-Loveland,ex1)" <dennis.miyoshi@hp.com>
To: "'Sam Ravnborg'" <sam@ravnborg.org>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: Build fails for ia64 with linux-2.6.0-test1-bk2 with missing 
	file .
Date: Tue, 22 Jul 2003 15:40:06 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2655.55)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aaah.  Now I understand.  Thanks for the clarification.  I'll proceed on
now.  Thanks again.

Dennis E. Miyoshi, PE
Hendrix Release Manager
Hewlett-Packard Company
825 14th Street, S.W.,  MS E-200
Loveland, CO  80537
(970) 898-6110


-----Original Message-----
From: Sam Ravnborg [mailto:sam@ravnborg.org] 
Sent: Tuesday, July 22, 2003 1:35 PM
To: MIYOSHI,DENNIS (HP-Loveland,ex1)
Cc: 'Sam Ravnborg'; 'linux-kernel@vger.kernel.org'
Subject: Re: Build fails for ia64 with linux-2.6.0-test1-bk2 with missing
file .


On Tue, Jul 22, 2003 at 07:41:16AM -0700, MIYOSHI,DENNIS (HP-Loveland,ex1)
wrote:
> Thanks Sam.  Shouldn't the Makefile take care of this?
No, the files located in asm-generic is meant to be included from
asm-$(ARCH) if needed.

	Sam
