Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161526AbWAMKHT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161526AbWAMKHT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 05:07:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161525AbWAMKHT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 05:07:19 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:12766 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1161526AbWAMKHR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 05:07:17 -0500
Subject: Re: machine check errors
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: don fisher <dfisher@as.arizona.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <43C6E834.7040402@as.arizona.edu>
References: <43C6E834.7040402@as.arizona.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 13 Jan 2006 10:10:44 +0000
Message-Id: <1137147044.3645.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2006-01-12 at 16:37 -0700, don fisher wrote:
> CPU 2 4 northbridge TSC 967b1992c66 
> ADDR 2a52cb5f0 
>   Northbridge Chipkill ECC error
>   Chipkill ECC syndrome = 40b9

Corrected ECC errors from memory. You've got bad memory but because you
have ECC memory it was able to recover the failure.

Alan

