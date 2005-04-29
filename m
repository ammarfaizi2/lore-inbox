Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262675AbVD2OCJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262675AbVD2OCJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 10:02:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262661AbVD2OCJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 10:02:09 -0400
Received: from [81.2.110.250] ([81.2.110.250]:10454 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S262675AbVD2N7m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 09:59:42 -0400
Subject: Re: Intel E7221 Server Board SATA
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: John Duthie <beyondgeek@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <b0fbeec405042822394a17a11f@mail.gmail.com>
References: <b0fbeec405042822394a17a11f@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1114783102.18355.278.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 29 Apr 2005 14:58:26 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-04-29 at 06:39, John Duthie wrote:
> if i get really desperate i might have to try the Redhat drivers - but
> I don't really want software raid just pain SATA .....

Boot 2.6.11ac7 on it and specify the boot option "all-generic-ide" and
it should grab the SATA device as generic IDE. That limits you to BIOS
configured speed and no other useful features but it is usually ok.

Alan

