Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269137AbRHBUmN>; Thu, 2 Aug 2001 16:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269140AbRHBUmE>; Thu, 2 Aug 2001 16:42:04 -0400
Received: from smtp018.mail.yahoo.com ([216.136.174.115]:8463 "HELO
	smtp018.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S269137AbRHBUlx>; Thu, 2 Aug 2001 16:41:53 -0400
X-Apparently-From: <rajeev?bector@yahoo.com>
From: "Rajeev Bector" <rajeev_bector@yahoo.com>
To: "Linux-Kernel" <linux-kernel@vger.kernel.org>
Subject: finding out module name from an address  ?
Date: Thu, 2 Aug 2001 13:39:12 -0700
Message-ID: <GIEMIEJKPLDGHDJKJELAGECPCCAA.rajeev_bector@yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2479.0006
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  I am trying to write a patched kmalloc() which
will track the caller function using 
__builtin_return_address(0). From that address,
is there a clean way to figure out if the address
belongs to a loadable module and if yes, get
to the module structure of that module so
that I can log on the basis of module->name

Thanks
Rajeev


_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

