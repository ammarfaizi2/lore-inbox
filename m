Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264432AbTFKLtn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 07:49:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264434AbTFKLtn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 07:49:43 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:14250
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S264432AbTFKLtm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 07:49:42 -0400
Subject: Re: Device-driver debugger on Linux ?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Mathur, Shobhit" <Shobhit_mathur@adaptec.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3EE7B34C.B803F915@adaptec.com>
References: <3EE7B34C.B803F915@adaptec.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1055332852.872.2.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 11 Jun 2003 13:00:58 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-06-11 at 23:55, Mathur, Shobhit wrote:
> Hello,
> 
> I would like to know whether there exists a device-driver debugger on
> Linux like SoftIce on Windows. From the working of kgdb, I understand
> that the debugging on the Target machine can happen once the code
> reaches the gdbstub, which is well past the driver-initialisations.

You can invoke the kgdbstubs stuff very very early, well before device
driver setup. Also you can (and its normally easier for development)
load device drivers at run time 

