Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263121AbTDBSzT>; Wed, 2 Apr 2003 13:55:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263126AbTDBSzT>; Wed, 2 Apr 2003 13:55:19 -0500
Received: from imail.ricis.com ([64.244.234.16]:40720 "EHLO imail.ricis.com")
	by vger.kernel.org with ESMTP id <S263121AbTDBSzR>;
	Wed, 2 Apr 2003 13:55:17 -0500
Date: Wed, 2 Apr 2003 13:06:43 -0600
From: lee leahu <lee@ricis.com>
To: linux-kernel@vger.kernel.org
Subject: Changing the VERSION statment in version.h
Message-Id: <20030402130643.087d4d26.lee@ricis.com>
Reply-To: lee@ricis.com
Organization: RICIS, Inc.
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Note: Send abuse reports to abuse@[(Private IP)].
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I am running SuSE OpenExchange Server version 4.  This server is based off the 2.4.19 kernel.  Since my server is a multi-processor machine, it has installed the SMP version of the standard kernel. 

Unfortunatly, the kernel sources are the standard sources used to build that standard single-processor kernel.  I need to build the drbd kernel module, but it keeps using the version '2.4.19-4gb' found in the version.h file.  If i change the VERSION statement to read '2.4.19-64GB-SMP' in the version.h file, will this break anything?

Thanks,
Lee

-- 
+----------------------------------+---------------------------------+
| Lee Leahu                        | voice -> 708-444-2690           |
| Internet Technology Specialist   | fax -> 708-444-2697             |
| RICIS, Inc.                      | email -> lee@ricis.com          |
+----------------------------------+---------------------------------+
| PGP Public Key:    http://www.dyweni.com/index2.php?page=gpg       | 
+--------------------------------------------------------------------+
| I cannot conceive that anybody will require multiplications at the |
| rate of 40,000 or even 4,000 per hour ...                          |
|               -- F. H. Wales (1936)                                |
+--------------------------------------------------------------------+
