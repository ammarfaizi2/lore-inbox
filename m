Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264296AbTLIJyp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 04:54:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264288AbTLIJyn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 04:54:43 -0500
Received: from pix-525-pool.redhat.com ([66.187.233.200]:15861 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S264296AbTLIJof (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 04:44:35 -0500
Date: Tue, 9 Dec 2003 10:43:56 +0100
From: Arjan van de Ven <arjanv@redhat.com>
To: Paul Menage <menage@google.com>
Cc: arjanv@redhat.com, agrover@groveronline.com, linux-kernel@vger.kernel.org,
       acpi-devel@lists.sourceforge.net
Subject: Re: ACPI global lock macros
Message-ID: <20031209094356.GA19702@devserv.devel.redhat.com>
References: <3FD59441.2000202@google.com> <1070962573.5223.2.camel@laptop.fenrus.com> <3FD5990A.9020908@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FD5990A.9020908@google.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 09, 2003 at 01:42:34AM -0800, Paul Menage wrote:
> Arjan van de Ven wrote:
> >
> >maybe the odd thing is that it exists at all?
> >(eg why does ACPI need to have it's own locking primitives...)
> 
> Because the ACPI spec defines its own locking protocol for 
> synchronization between the OS and the BIOS.

... which can't be written based on linux locks ?
