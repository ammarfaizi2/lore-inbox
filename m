Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276444AbRJYVmz>; Thu, 25 Oct 2001 17:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276448AbRJYVmp>; Thu, 25 Oct 2001 17:42:45 -0400
Received: from AMontpellier-201-1-4-3.abo.wanadoo.fr ([217.128.205.3]:22283
	"EHLO awak") by vger.kernel.org with ESMTP id <S276444AbRJYVmd> convert rfc822-to-8bit;
	Thu, 25 Oct 2001 17:42:33 -0400
Subject: RE: Issue wit ACPI and Promise?
From: Xavier Bestel <xavier.bestel@free.fr>
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: "'Gert-Jan Rodenburg'" <hertog@home.nl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <59885C5E3098D511AD690002A5072D3C42D6A7@orsmsx111.jf.intel.com>
In-Reply-To: <59885C5E3098D511AD690002A5072D3C42D6A7@orsmsx111.jf.intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/0.16.99+cvs.2001.10.22.19.14 (Preview Release)
Date: 25 Oct 2001 23:36:35 +0200
Message-Id: <1004045796.10130.114.camel@nomade>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

le jeu 25-10-2001 à 00:42, Grover, Andrew a écrit :
> The IDE controller is on irq 9 and I bet ACPI is, too. I've seen other
> reports like this.
> 
> Either the ACPI interrupt handler is not sharing properly or the promise
> interrupt handler isn't. Given that I can't duplicate it, I'm reduced to
> waiting for some kind soul to send a patch.. :-(

I've seen exactely this problem (reproducable, and I'm not alone),
without Promise. It seems it's ACPI.

	Xav

