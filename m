Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317802AbSFMTV6>; Thu, 13 Jun 2002 15:21:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317803AbSFMTV5>; Thu, 13 Jun 2002 15:21:57 -0400
Received: from natpost.webmailer.de ([192.67.198.65]:7357 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S317802AbSFMTV5> convert rfc822-to-8bit; Thu, 13 Jun 2002 15:21:57 -0400
Content-Type: text/plain; charset=US-ASCII
From: Martin Knoblauch <knobi@knobisoft.de>
Reply-To: knobi@knobisoft.de
Organization: Knobisoft :-)
To: Greg KH <greg@kroah.com>
Subject: Re: USB Problems with 2.4.19-pre10-ac2
Date: Thu, 13 Jun 2002 21:23:58 +0200
User-Agent: KMail/1.4.1
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200206131916.16214.knobi@knobisoft.de> <20020613173655.GD21644@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200206132123.58896.knobi@knobisoft.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> I would be very interested to see if this proble also happens on
> 2.4.19-pre10.
>
Greg,

 problem solved. There was an apparently important difference between my 
.config and the SuSE one. Me enabling CONFIG_X86_UP_APIC and
CONFIG_X86_UP_IOAPIC messed up USB somehow...

Sorry for the confusion
Martin
-- 
----------------------------------
Martin Knoblauch
knobi@knobisoft.de
http://www.knobisoft.de
