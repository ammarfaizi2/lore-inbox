Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262379AbTFVWgC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 18:36:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263152AbTFVWgC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 18:36:02 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:24015
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S262379AbTFVWgA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 18:36:00 -0400
Subject: Re: Spurious 8259A Interrupt IRQ 7
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: war@lucidpixels.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030622222014.7827.qmail@lucidpixels.com>
References: <20030622222014.7827.qmail@lucidpixels.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1056322074.2075.40.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 22 Jun 2003 23:47:54 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

IRQ7 is raised if an interrupt appears and then vanishes again before it
can be serviced. For 2.4.20/21 at least it can occur from the IDE layer
and maybe others

