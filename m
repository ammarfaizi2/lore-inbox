Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318113AbSIET5f>; Thu, 5 Sep 2002 15:57:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318115AbSIET5f>; Thu, 5 Sep 2002 15:57:35 -0400
Received: from ip213-185-39-113.laajakaista.mtv3.fi ([213.185.39.113]:22244
	"HELO dag.newtech.fi") by vger.kernel.org with SMTP
	id <S318113AbSIET5c> convert rfc822-to-8bit; Thu, 5 Sep 2002 15:57:32 -0400
Message-ID: <20020905200208.22430.qmail@dag.newtech.fi>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-0.27
To: Linux-SCSI Mailingliste <linux-scsi@vger.kernel.org>
cc: Linux-Kernel Mailingliste <linux-kernel@vger.kernel.org>, dag@newtech.fi
Subject: Re: blocksize limitations in scsi tape driver (st) when used with 
 DLT1 tape drives?
In-Reply-To: Message from Friedrich Lobenstock <fl@fl.priv.at> 
   of "Thu, 05 Sep 2002 21:35:50 +0200." <3D77B216.8070205@fl.priv.at> 
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Date: Thu, 05 Sep 2002 23:02:08 +0300
From: Dag Nygren <dag@newtech.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I have successfully been using Legato Networker with a
blocksize of 32k with my DLT here.

But the way Legato wants to do it is to decide about the
blocksize itself.
This means that the driver should NOT decide on the BS, but
pass on anything written through it, meaning a blocksize setting
of 0 (or variable blocksize).

Perhaps Arkeia works the same way ?

Best Luck


-- 
Dag Nygren                               email: dag@newtech.fi
Oy Espoon NewTech Ab                     phone: +358 9 8024910
Träsktorpet 3                              fax: +358 9 8024916
02360 ESBO                              Mobile: +358 400 426312
FINLAND


