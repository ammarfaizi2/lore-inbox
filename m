Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265358AbSJXJG6>; Thu, 24 Oct 2002 05:06:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265359AbSJXJG6>; Thu, 24 Oct 2002 05:06:58 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:22276 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S265358AbSJXJG5>; Thu, 24 Oct 2002 05:06:57 -0400
Message-Id: <200210240906.g9O96Gp08544@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: "Ashwin Sawant" <sawant_ashwin@rediffmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Workqueues and the Nvidia driver
Date: Thu, 24 Oct 2002 11:58:51 -0200
X-Mailer: KMail [version 1.3.2]
References: <20021023175255.547.qmail@webmail30.rediffmail.com>
In-Reply-To: <20021023175255.547.qmail@webmail30.rediffmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 October 2002 15:52, Ashwin  Sawant wrote:
> I have successfully compiled the latest Nvidia driver with kernel
> 2.5.44 on a heavily modified RH 7.2 (original compiler) box  after
> applying the patch posted to this list previously. However it
> can't be loaded because insmod bombs out saying that, IIRC,
> create_workqueue, flush_workqueue, and a couple of other similar
> symbols are unresolved.
> nm vmlinux shows that these symbols exist and this is (obviously)
> reflected in the System.map. However, the proc interface doesn't
> show them. I use modutils-2.4.6.

Way old. Maybe not the cause of your problem, but I see there are
modutils 2.4.21
--
vda
