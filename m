Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263170AbSJBQ42>; Wed, 2 Oct 2002 12:56:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263171AbSJBQ42>; Wed, 2 Oct 2002 12:56:28 -0400
Received: from server.s8.com ([66.77.12.139]:62725 "EHLO server.s8.com")
	by vger.kernel.org with ESMTP id <S263170AbSJBQ4X>;
	Wed, 2 Oct 2002 12:56:23 -0400
Subject: Re: 3ware Escalade 7500 init problems on 2.4.19
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: Ken Savage <kens1835@shaw.ca>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200210020859.54621.kens1835@shaw.ca>
References: <200210020859.54621.kens1835@shaw.ca>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 02 Oct 2002 10:01:43 -0700
Message-Id: <1033578103.8610.12.camel@plokta.s8.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-10-02 at 08:59, Ken Savage wrote:

> SCSI support and SCSI disk support are enabled.
> Low level support for 3w-xxxx is enabled.

The driver that ships with 2.4.19 isn't the most recent, though I doubt
there's anything in the up-to-date driver that should make a difference.

You can download the newest driver from www.3ware.com - just drop its
3w-xxxx.[ch] over the ones in your kernel source tree, recompile,
install, and reboot.

The error message you report is replicated in several spots within the
driver, so it's not useful in itself.

	<b
