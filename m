Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261932AbTEFVaZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 17:30:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261960AbTEFVaZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 17:30:25 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:19586
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S261932AbTEFVaX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 17:30:23 -0400
Subject: Re: [PATCH][2.5.69][PNP] Remove deprecated __check_region
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bongani Hlope <bonganilinux@mweb.co.za>
Cc: ambx1@neo.rr.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030506231822.201511c6.bonganilinux@mweb.co.za>
References: <20030506231822.201511c6.bonganilinux@mweb.co.za>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052253778.1983.168.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 06 May 2003 21:42:59 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-05-06 at 22:18, Bongani Hlope wrote:
> Hi Adam
> 
> You are listed as the maintainer of the ISAPNP code in the Maintainers file. 
> Could you verify if this patch is fine and forward it to Linus. The patch 
> has been test for compilation.

This isnt what is needed. The PnP code needs to claim with
request_region but also needs to handle giving it back on error. So its
not quite as trivial

