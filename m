Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264412AbTDPPIB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 11:08:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264454AbTDPPIA 
	(for <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 11:08:00 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:40899
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S264412AbTDPPHz (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 16 Apr 2003 11:07:55 -0400
Subject: Re: How to identify contents of /lib/modules/*
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: steve.cameron@hp.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030416020059.GA27314@zuul.cca.cpqcorp.net>
References: <20030416020059.GA27314@zuul.cca.cpqcorp.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1050502898.28591.76.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 16 Apr 2003 15:21:38 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-04-16 at 03:00, Stephen Cameron wrote:
> The task for the binary driver distributor becomes to figure out which
> of these multiple errata kernels found in /boot corresponds to the 
> /lib/modules directory, so we can drop the binary driver that was
> made for that errata kernel in there, and not a driver made for the
> wrong kernel.

if its an rpm based distro

	rpm -qf /lib/modules/[version]/something

will tell you which kernel owns the file.

Its a horrible thing to need to do however

