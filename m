Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266936AbSKLUbu>; Tue, 12 Nov 2002 15:31:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266939AbSKLUbu>; Tue, 12 Nov 2002 15:31:50 -0500
Received: from server.s8.com ([66.77.12.139]:51212 "EHLO server.s8.com")
	by vger.kernel.org with ESMTP id <S266936AbSKLUbt>;
	Tue, 12 Nov 2002 15:31:49 -0500
Subject: GA-7VRXP is a bad motherboard [was Re: PDC20276 Linux driver]
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: Geoffrey Lee <glee@gnupilgrims.org>
Cc: ricci@trinityteam.it, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021112165309.GB12789@anakin.wychk.org>
References: <1037117166.8313.61.camel@irongate.swansea.linux.org.uk>
	<Pine.LNX.4.21.0211121649360.9631-100000@esentar.trinityteam.it> 
	<20021112165309.GB12789@anakin.wychk.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 12 Nov 2002 12:38:30 -0800
Message-Id: <1037133511.7047.12.camel@plokta.s8.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-11-12 at 08:53, Geoffrey Lee wrote:

> Board is a Gigabyte GA-7VRXP which has an on-board Promise 20276.

The GA-7VRXP is a known bad motherboard.  It has a bad electrical
interface to the AGP slot, so if you're using an AGP graphics card
without falling back to PCI access, you are pretty much guaranteed
system hangs or crashes after some time, depending on load.

This is an issue I confirmed with AMD several (six?) months ago.  I
don't know of any workarounds that maintain decent graphics performance,
and last I checked, Gigabyte had not acknowledged the problem.

Either drop your video card back to not using AGP, or buy a replacement
motherboard.

	<b

