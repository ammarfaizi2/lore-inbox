Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267389AbUGNOhE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267389AbUGNOhE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 10:37:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267400AbUGNOfG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 10:35:06 -0400
Received: from ngate.noida.hcltech.com ([202.54.110.230]:35994 "EHLO
	ngate.noida.hcltech.com") by vger.kernel.org with ESMTP
	id S267425AbUGNOOy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 10:14:54 -0400
Message-ID: <1B3885BC15C7024C845AAC78314766C508AF7A72@exch-01.noida.hcltech.com>
From: "Deepak Kumar Gupta, Noida" <dkumar@noida.hcltech.com>
To: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Cc: Takao Indoh <indou.takao@soft.fujitsu.com>,
       lkcd-devel@lists.sourceforge.net
Subject: RE: [lkcd-devel] Re: [RFC] Standard filesystem types for crash du
	mping
Date: Wed, 14 Jul 2004 19:42:24 +0530
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Keith Owens wrote:
> Follow ups to lkml please, to keep any discussion on the same list.
> 
> Several kernel additions exist for saving crash dump information, among
> them are lkcd, crash, kmsgdump.  They all have the same problems :-
> 
> * Where to store the crash data.
> * How to write data when the kernel is unreliable, it may not be
>   servicing interrupts.
> * User space needs to read and clear the dump data.
> * Performance!
> * Coexistence of multiple dump drivers.


jeff>Have you tried diskdump?

jeff> It already exists, and seems to address these things.

I guess this RFC proposes a common interface (can be used all the dumping
mechanisms available in Linux kernel) to handle the above points. And
diskdump is specific to LKCD only.

Thanks and Best Regards
Deepak Kumar Gupta
Project Leader
HCL Technologies Limited, NOIDA UP, INDIA

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Contributing to the World by creating indispensable value !

System Software CoE @ HCLT-Noida
http://www.hcltechnologies.com
Ph. : +91-120-2510701/702 Ext : 3159
FAX : +91-120-2510713 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 


Disclaimer: 

This message and any attachment(s) contained here are information that is
confidential,proprietary to HCL Technologies and its customers, privileged
or otherwise protected by law.The information is solely intended for the
individual or the entity it is addressed to. If you are not the intended
recipient of this message, you are not authorized to read, forward,
print,retain, copy or disseminate this message or any part of it. If you
have received this e-mail in error, please notify the sender immediately by
return e-mail and delete it from your computer.


