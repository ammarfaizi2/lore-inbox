Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261532AbVBSLs4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261532AbVBSLs4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 06:48:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261538AbVBSLs4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 06:48:56 -0500
Received: from wproxy.gmail.com ([64.233.184.197]:2114 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261532AbVBSLsy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 06:48:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=FA8bm3D0jLQuqfjA/T1L+BUtJq8tjve7OQbiHvoIcjvnbqoeguehApBrD9959TGUyqDDc+yhx64yNcc0VMMEm2nYqxRcw05NJC8BB9y7nnEm7lXw6J4+OuTiRvol3SHyLqtU2KhzkqU5q/NSM4ISldL4Qf0X6qffq0lgAps5+Uw=
Message-ID: <58cb370e05021903481de251df@mail.gmail.com>
Date: Sat, 19 Feb 2005 12:48:52 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       linux-kernel@vger.kernel.org
Subject: Re: FAUmachine: Looking for a good documented DMA bus master capable PCI IDE Controller card
In-Reply-To: <20050219102410.GD16858@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050219102410.GD16858@cip.informatik.uni-erlangen.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 19 Feb 2005 11:24:10 +0100, Thomas Glanzmann
<sithglan@stud.uni-erlangen.de> wrote:
> Hello,
> we just implemented the Intel PIIX DMA Bus Master capable IDE Controller
> in FAUmachine. This improved the IO access to virtual IDE Devices using
> DMA as transport mechanism a lot.
> 
> But with the current simulation it is only possible to access 4 devices
> via DMA.
> 
> Because of that I am looking for a good documented PCI IDE Controller
> Card to provide DMA access to more than 4 devices with public available
> documentation. Any pointers?

In IDE you have 2 devices per port and usually 2 ports per PCI device.
There are some controller cards with 4 ports but they don't have public
available documentation etc.  I really wonder what are you trying to
achieve and why just can't you use more than 1 "virtual" PIIX crontoller.

Bartlomiej
