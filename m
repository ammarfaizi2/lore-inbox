Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932092AbVKDOO2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932092AbVKDOO2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 09:14:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932737AbVKDOO2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 09:14:28 -0500
Received: from nproxy.gmail.com ([64.233.182.194]:60933 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932092AbVKDOO1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 09:14:27 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LTRKM2m3c0SV5wWRu4GS7NdVrl+lF8cr5YA0mE1z7AfWiAhofyfHIgo1vlev3TI2gZp3zlPA50Q6LMMxD4ff0PCdZFmmCeVD2lawl93z2ox//cFY92N0N8P1OV6HGnS6lKDRlq5L/1VB/IoVfyl70rKwonzacs6yui2cJ0bx6Ao=
Message-ID: <58cb370e0511040614p789cd8cfxc9ec40b5ef456bee@mail.gmail.com>
Date: Fri, 4 Nov 2005 15:14:26 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Kyuma Ohta <whatisthis@jcom.home.ne.jp>
Subject: Re: [x86_64] Freeze using IDE as upper than ATA33
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051104.223654.432830398.whatisthis@jcom.home.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051104.223654.432830398.whatisthis@jcom.home.ne.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/4/05, Kyuma Ohta <whatisthis@jcom.home.ne.jp> wrote:
> Hi,
> I'm using ASUS Mainboard for Athlon 64 3000+ with VIA K8T800Pro
> Host Bridge and VIA VT8237 South Bride for IDE.
>
> I'm running linux-kernel-2.6.14 , when re-constructureing RAID1
>  with two ATA100 Drives (IBM/Hitachi) a, kernel was locked with no
> message.
>
> I tried to be booting with  "ide0=ata66 ide1=ata66", but freezed yet.

Are you using proper cables (80-wires)?

> I tried  booting with "idebus=33", very stable,not freezed.

This is the default setting, no need to force it.

> Devices are:

dmesg output please

Bartlomiej
