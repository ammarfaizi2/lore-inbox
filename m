Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263245AbVCKJx4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263245AbVCKJx4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 04:53:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263244AbVCKJx4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 04:53:56 -0500
Received: from fire.osdl.org ([65.172.181.4]:38345 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263240AbVCKJxA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 04:53:00 -0500
Date: Fri, 11 Mar 2005 01:46:01 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jan Kasprzak <kas@fi.muni.cz>
Cc: paulus@samba.org, jt@bougret.hpl.hp.com, javier@tudela.mad.ttd.net,
       linux-fbdev-devel@lists.sourceforge.net,
       acpi-devel@lists.sourceforge.net, linux1394-devel@lists.sourceforge.net,
       roland@topspin.com, linux-kernel@vger.kernel.org
Subject: Re: [ACPI] inappropriate use of in_atomic()
Message-Id: <20050311014601.166ae43d.akpm@osdl.org>
In-Reply-To: <20050311091142.GB22415@fi.muni.cz>
References: <20050310204006.48286d17.akpm@osdl.org>
	<20050311091142.GB22415@fi.muni.cz>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Kasprzak <kas@fi.muni.cz> wrote:
>
> This may be the cause of 
> 
>  http://bugme.osdl.org/show_bug.cgi?id=4150

Looks that way, yes.
