Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267984AbUJDTVd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267984AbUJDTVd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 15:21:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268487AbUJDTVM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 15:21:12 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:19103
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S267984AbUJDTNL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 15:13:11 -0400
Subject: Re: [PATCH / RFC] Shared Reed-Solomon ECC Library
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Bill Davidsen <davidsen@tmr.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <41619B74.8070802@tmr.com>
References: <1096670893.25635.41.camel@thomas>  <41619B74.8070802@tmr.com>
Content-Type: text/plain
Organization: linutronix
Message-Id: <1096916727.21297.445.camel@thomas>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 04 Oct 2004 21:05:27 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-10-04 at 20:50, Bill Davidsen wrote:
> > the attached patch contains a shared Reed-Solomon Library analogous to
> > the shared zlib.
>
> One use would be very reliable CD/DVD for backup. I believe there's a 
> freshmeat project which addresses this problem, but a reliable optical 
> device certainly sounds easy using this approach.

Most data storage devices use RS codes for data integrity, including
CD/DVD/HD devicesm but the ECC mechanisms are built into the device
itself. 
Modems and wireless communication devices use similar but more complex 
techniques based on polynomial encoding/decoding. 

tglx


