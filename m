Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264279AbTGKQ6V (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 12:58:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263315AbTGKQ4p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 12:56:45 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:19384
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S264472AbTGKQ4G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 12:56:06 -0400
Subject: Re: AMD760MPX: bogus chispset ? (was PROBLEM: sound is stutter,
	sizzle with lasts kernel releases)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: xi <xizard@enib.fr>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3F0EED9B.4080502@enib.fr>
References: <3F0EED9B.4080502@enib.fr>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1057943291.20629.30.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 11 Jul 2003 18:08:14 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-07-11 at 18:02, xi wrote:
> Now I have done some investigations, and I think I have found the 
> problem: It has appeared between kernel-2.4.18-pre9 and kernel-2.4.18-rc1
> If I am not wrong, between these two versions, Alan Cox did a change in 
> drivers/pci/quirks.c and this is this change which cause the problem.

As I read the documentation the other change is also required in this
situation to avoid a chipset lockup. It might be worth you rechecking
the AMD errata docs for 762/768 again to be sure I didnt screw up and
there are not newer rules for other revisions. 

