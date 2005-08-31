Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964923AbVHaWPk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964923AbVHaWPk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 18:15:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964925AbVHaWPj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 18:15:39 -0400
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:38581 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S964923AbVHaWPi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 18:15:38 -0400
X-ORBL: [67.124.117.85]
Date: Wed, 31 Aug 2005 15:15:35 -0700
From: Chris Wedgwood <cw@f00f.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Alon Bar-Lev <alon.barlev@gmail.com>, Andrew Morton <akpm@osdl.org>,
       SYSLINUX@zytor.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: THE LINUX/I386 BOOT PROTOCOL - Breaking the 256 limit
Message-ID: <20050831221535.GB14806@taniwha.stupidest.org>
References: <4315B668.6030603@gmail.com> <43162148.9040604@zytor.com> <20050831215757.GA10804@taniwha.stupidest.org> <431628D5.1040709@zytor.com> <20050831220717.GA14625@taniwha.stupidest.org> <43162B6A.2010806@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43162B6A.2010806@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2005 at 03:12:58PM -0700, H. Peter Anvin wrote:

> Well, we have initramfs for the really big stuff.  The kernel
> shouldn't really need that much data, though.

except the initrd image is in many cases fairly fixed; right now i
have options i pass into initramfs by passing arguments on the command
line which initrd them reads, parses and uses that to grab a file from
the network

it's a tad disconnected to have to do this though
