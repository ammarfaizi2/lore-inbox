Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263270AbTFDLta (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 07:49:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263264AbTFDLta
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 07:49:30 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:27523
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263270AbTFDLt3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 07:49:29 -0400
Subject: Re: siimage slow on 2.4.21-rc6-ac2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Mauk van der Laan <mauk.lists@maatwerk.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.10.10306031746070.27756-100000@master.linux-ide.org>
References: <Pine.LNX.4.10.10306031746070.27756-100000@master.linux-ide.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1054724701.9233.100.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 04 Jun 2003 12:05:01 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-06-04 at 01:53, Andre Hedrick wrote:
> drive->id->hwconfig |= 0x6000;
> 
> Is needed to fake the driver for device side cable detect.
> There are several issues and I have not had time to keep up.

The SI3112 ignores the word93 check.
