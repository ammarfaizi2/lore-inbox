Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261919AbVCWSDJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261919AbVCWSDJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 13:03:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262741AbVCWSDJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 13:03:09 -0500
Received: from stargate.chelsio.com ([64.186.171.138]:63347 "EHLO
	stargate.chelsio.com") by vger.kernel.org with ESMTP
	id S261919AbVCWSDE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 13:03:04 -0500
content-class: urn:content-classes:message
Subject: RE: Module compiling issue
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Date: Wed, 23 Mar 2005 10:02:35 -0800
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Message-ID: <67D69596DDF0C2448DB0F0547D0F947E01241A3B@yogi.asicdesigners.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Module compiling issue
Thread-Index: AcUvz3aHuF4ggYYpQfaYx7ASW8WSmQAAoW5a
From: "Scott Bardone" <sbardone@chelsio.com>
To: <AndyLiebman@aol.com>, <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy,
These Makefiles are not written as a stand-alone make, they are for the kernel to build the objects. If you want the modules built, just run "make modules" from the top-level kernel after configuring the drivers to be built as modules. 

Scott Bardone
Chelsio Communications


-----Original Message-----
From:	linux-kernel-owner@vger.kernel.org on behalf of AndyLiebman@aol.com
Sent:	Wed 3/23/2005 9:38 AM
To:	linux-kernel@vger.kernel.org
Cc:	
Subject:	Module compiling issue
I know this isn't the best place to ask this  question -- it's kind of a 
newbie question -- but I'm very frustrated.  

Ever since I started using the 2.6.9 kernel and above, I have had  frequent 
troubles compiling drivers AFTER the new kernel is installed and booted  up. 

In other words, no issue compiling the kernel itself, as well as all  the 
modules. But then, if I try to compile a module later (i.e., 3ware 9xxx  driver 
or Chelsio 10 Gigabit NIC driver), when I type: 

"make" or "make  -f Makefile" I get back an error: 

"No rule to make target 'for' "   or "No rule to make target 'driver' ".  
Have I missed configuring something  in the kernel. I have gotten this to work 
once with the 2.6.10 kernel, but I  don't know what I did differently then. 

I would appreciate your help  here. 

Andy Liebman  

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/



