Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262054AbUBZPXn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 10:23:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261962AbUBZPXn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 10:23:43 -0500
Received: from mail0.lsil.com ([147.145.40.20]:25542 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S261948AbUBZPXl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 10:23:41 -0500
Message-ID: <0E3FA95632D6D047BA649F95DAB60E57033BC3F4@exa-atlanta.se.lsil.com>
From: "Mukker, Atul" <Atulm@lsil.com>
To: "'Matt Domsch'" <Matt_Domsch@dell.com>,
       "'Jeff Garzik'" <jgarzik@pobox.com>
Cc: "'Christoph Hellwig'" <hch@infradead.org>,
       "'Arjan van de Ven'" <arjanv@redhat.com>,
       "'James Bottomley'" <James.Bottomley@SteelEye.com>,
       "'Paul Wagland'" <paul@wagland.net>, Matthew Wilcox <willy@debian.org>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>
Subject: RE: [SUBJECT CHANGE]: megaraid unified driver version 2.20.0.0-al
	 pha1
Date: Thu, 26 Feb 2004 10:21:39 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 better name), loaded by both mptraid and megaraid automatically, which
> handles registering the /dev/megaraid node dynamically.  In this case,
> both mptraid and megaraid would register with lsiioctl for each
> adapter discovered, and lsiioctl would essentially be a switch,
> redirecting userspace tool ioctls to the appropriate driver.
This seems to me a very interesting idea and good one. We would definitely
explore this idea now and implement. Thanks Jeff, Matt.

-Atul
