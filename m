Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932183AbWC3MHE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932183AbWC3MHE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 07:07:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932188AbWC3MHD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 07:07:03 -0500
Received: from spitalnik.net ([86.49.85.240]:35777 "EHLO
	spity-nb.home.spitalnik.net") by vger.kernel.org with ESMTP
	id S932183AbWC3MHB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 07:07:01 -0500
From: Jan Spitalnik <jan@spitalnik.net>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: ACPI assign-busses
Date: Thu, 30 Mar 2006 14:07:05 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <200603300223.13530.jan@spitalnik.net> <20060329192616.4644963e.akpm@osdl.org>
In-Reply-To: <20060329192616.4644963e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200603301407.05848.jan@spitalnik.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dne ètvrtek 30 bøezen 2006 05:26 Andrew Morton napsal(a):
> Jan Spitalnik <jan@spitalnik.net> wrote:
> > while playing with 2.6.16-git kernel from today, I've found out following
> >  message in dmesg:
> >
> >  PCI: Bus #04 (-#07) is hidden behind transparent bridge #02 (-#04)
> >  (try 'pci=assign-busses')
> >
> >  My notebook is HP nc6120 (Pent-M, ICH6). So i've rebooted with said
> > parameter and dmesg changed a bit, finding new "resources" (not sure
> > what's the proper terminology :)
>
> Did everything actually work OK when pci=assign-busses was not used?

Yeah, I didn't notice any change after using pci=assign-busses - the dmesg 
shown changes in cardbus, among other things, so i tested my only pcmcia card 
I have (cf card reader) and it worked well w/ and w/o the param.

-- 
Jan Spitalnik
jan@spitalnik.net
