Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261495AbVETRal@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261495AbVETRal (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 13:30:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbVETRal
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 13:30:41 -0400
Received: from mail2.dolby.com ([204.156.147.24]:46346 "EHLO dolby.com")
	by vger.kernel.org with ESMTP id S261495AbVETRad convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 13:30:33 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Subject: RE: Illegal use of reserved word in system.h
Date: Fri, 20 May 2005 10:30:14 -0700
Message-ID: <2692A548B75777458914AC89297DD7DA08B08680@bronze.dolby.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Illegal use of reserved word in system.h
Thread-Index: AcVdMheqBnGQ1H7SRrqiH7CAMj8COgALrv1Q
From: "Gilbert, John" <JGG@dolby.com>
To: "Dave Airlie" <airlied@gmail.com>, <linux-kernel@vger.kernel.org>
Content-Type: text/plain;
	charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dave,
I've already searched through the 2.6.11+ kernels, it's only used in
drm_bufs.c and drm.h (see previous patches). I can't vouch for any
applications, I probably should look through xorg at least (although a
name change won't effect binaries).
John Gilbert
jgg@dolby.com 

-----Original Message-----
From: Dave Airlie [mailto:airlied@gmail.com] 
Sent: Friday, May 20, 2005 4:50 AM
To: Alan Cox
Cc: Gilbert, John; Linux Kernel Mailing List
Subject: Re: Illegal use of reserved word in system.h

> 
> DRI one does seem to be a real bug.

Well not a bug :-) but lets call it a C++ incompatibility .. I'll see
how much work it is to change this everywhere it is used..  I don't
really want to break loads of userspace apps.. not that many drm apps
exist.. and probably very few of them use the virtual pointer...

Dave.


-----------------------------------------
This message (including any attachments) may contain confidential
information intended for a specific individual and purpose.  If you are not
the intended recipient, delete this message.  If you are not the intended
recipient, disclosing, copying, distributing, or taking any action based on
this message is strictly prohibited.

