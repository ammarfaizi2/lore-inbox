Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264973AbTFUQ7U (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 12:59:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264999AbTFUQ7U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 12:59:20 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:60617
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S264973AbTFUQ7T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 12:59:19 -0400
Subject: Re: CONFIG_IDEDISK_MULTI_MODE in 2.4.21
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Nick Bartos <spam@2thebatcave.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <39163.65.23.2.202.1055781578.squirrel@localhost>
References: <39163.65.23.2.202.1055781578.squirrel@localhost>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1056215473.1584.18.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 21 Jun 2003 18:11:14 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-06-16 at 17:39, Nick Bartos wrote:
> I copied back in the old code from 2.4.20 for the option but I still get
> errors, I am guessing that it was removed because something was changed so
> that it no longer mattered or something.

We now just check if the device claims it supports multimode and if so
try and set a mode that is suitable

