Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932420AbVLESrS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932420AbVLESrS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 13:47:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932419AbVLESrO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 13:47:14 -0500
Received: from mx1.redhat.com ([66.187.233.31]:42419 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932455AbVLESrL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 13:47:11 -0500
Date: Mon, 5 Dec 2005 13:46:56 -0500
From: Dave Jones <davej@redhat.com>
To: Bryce Nesbitt <bryce1@obviously.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix ECC error counting for AMD76x chipset, char/ecc.c driver
Message-ID: <20051205184656.GH12664@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Bryce Nesbitt <bryce1@obviously.com>, linux-kernel@vger.kernel.org
References: <4394864D.3000704@obviously.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4394864D.3000704@obviously.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2005 at 10:26:21AM -0800, Bryce Nesbitt wrote:
 > Summary:
 > * Patch is relevant to driver "char/ecc.c", for the AMD76x Athlon chipset.
 > 
 > * Note: this module is often not installed by default: do "modprobe ecc"
 > then "cat /proc/ram" to check your ECC memory for detected soft errors.
 > * Patch is against Linux-2.6.13, the last kernel I could find with ecc.c
 > * Tabs suck.
 > 
 > I am an infrequent contributor, and did not find a matching entry in the
 > ./MAINTAINERS file.  Please help me to understand the proper procedure
 > for submitting this patch.  I understand that perhaps ecc.c is changing
 > soon.  So maybe it's not the most important patch, but it does fix a
 > real bug, and is quite simple.

drivers/char/ecc.c only lives in various vendor kernels.

you may want to check if your patch is relevant to the edac
code present in -mm though.

		Dave

