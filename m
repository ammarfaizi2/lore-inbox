Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264614AbSLGRTJ>; Sat, 7 Dec 2002 12:19:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264617AbSLGRTJ>; Sat, 7 Dec 2002 12:19:09 -0500
Received: from mailout10.sul.t-online.com ([194.25.134.21]:13746 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S264614AbSLGRTI> convert rfc822-to-8bit; Sat, 7 Dec 2002 12:19:08 -0500
Content-Type: text/plain; charset=US-ASCII
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: error compiling 2.5.50
Date: Sat, 7 Dec 2002 18:26:31 +0100
User-Agent: KMail/1.4.3
References: <200212071817.03142.roy@karlsbakk.net>
In-Reply-To: <200212071817.03142.roy@karlsbakk.net>
Organization: WOLK - Working Overloaded Linux Kernel
Cc: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212071826.31636.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 07 December 2002 18:17, Roy Sigurd Karlsbakk wrote:

Hi Roy,

> I get this error when compiling 2.5.50. .config is attached
> thanks for any help

> drivers/pci/quirks.c:354: `sis_apic_bug' undeclared (first use in this
> function)
> drivers/pci/quirks.c:354: (Each undeclared identifier is reported only once
> drivers/pci/quirks.c:354: for each function it appears in.)

<movement> RoyK: mail archives are a wonderful thing
<arashi> patch in bk, insert an 'extern int sis_apic_bug;' as a new line 
before 354

ciao, Marc
