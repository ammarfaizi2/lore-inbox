Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262103AbUC1Hh3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 02:37:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262089AbUC1Hh3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 02:37:29 -0500
Received: from 1-2-2-1a.has.sth.bostream.se ([82.182.130.86]:44211 "EHLO
	K-7.stesmi.com") by vger.kernel.org with ESMTP id S262108AbUC1Hh0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 02:37:26 -0500
Message-ID: <406680AB.8090204@stesmi.com>
Date: Sun, 28 Mar 2004 09:37:15 +0200
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7b) Gecko/20040316
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "J. Ryan Earl" <heretic@clanhk.org>
CC: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: Status of the sata_sil driver for the VT8237
References: <4066342B.4080105@clanhk.org> <406643A8.2050808@pobox.com> <40664AE4.8010003@clanhk.org>
In-Reply-To: <40664AE4.8010003@clanhk.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

> I meant sata_via, I dunno why I said sata_sil; Freudian typo.  I was 
> thinking of the current sii3112 I use, which has been stable and 
> blazingly fast for awhile with the IDE driver--and a little little patch 
> I keep applying.  I'm looking to upgrade a server with 2 Raptors in it 
> to an A64 running 64-bit Linux of course.  I wanna get the HDs off the 
> PCI bus and onto the VT8237 southbridge.  I was wondering if the driver 
> for -that southbridge- was still considered beta.

Many A64 boards today come with a Promise SATA controller as well -
works like a charm for me on an ASUS K8V Deluxe board here.

The driver is sata_promise but I guess you either knew that or
would be able to figure it out yourself :)

// Stefan
