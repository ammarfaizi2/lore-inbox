Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263183AbTDYK6i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 06:58:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263518AbTDYK6i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 06:58:38 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:30855
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263183AbTDYK6h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 06:58:37 -0400
Subject: Re: [PATCH 2.4] dmi_ident made public
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jean Delvare <khali@linux-fr.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, sp@osb.hu
In-Reply-To: <20030425121517.28c9002b.khali@linux-fr.org>
References: <20030424184759.5f7b3323.khali@linux-fr.org>
	 <20030424231028.GA29393@kroah.com>
	 <20030425121517.28c9002b.khali@linux-fr.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1051265517.5460.11.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 25 Apr 2003 11:11:57 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-04-25 at 11:15, Jean Delvare wrote:
> What's more, I plan to write another module that exports the DMI data,
> as scanned at boot time, to userland (via sysfs), and such a module
> definitely requires that the DMI data is made public in dmi_scan.

I suspect the DMI module should itself do the sysfs interface, and I 
certainly think the idea of it being in sysfs has merit.


