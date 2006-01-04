Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932499AbWADDeF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932499AbWADDeF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 22:34:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932509AbWADDeE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 22:34:04 -0500
Received: from mx.pathscale.com ([64.160.42.68]:30950 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932499AbWADDeE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 22:34:04 -0500
Subject: Re: [PATCH 0 of 20] [RFC] ipath - PathScale InfiniPath driver
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1136323614.2869.20.camel@laptopd505.fenrus.org>
References: <patchbomb.1135816279@eng-12.pathscale.com>
	 <20051230080002.GA7438@kroah.com>
	 <1135984304.13318.50.camel@serpentine.pathscale.com>
	 <20051231001051.GB20314@kroah.com>
	 <1135993250.13318.94.camel@serpentine.pathscale.com>
	 <20060103172732.GA9170@kroah.com>
	 <1136321691.10862.61.camel@localhost.localdomain>
	 <1136321851.2869.18.camel@laptopd505.fenrus.org>
	 <1136323485.10862.74.camel@localhost.localdomain>
	 <1136323614.2869.20.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Date: Tue, 03 Jan 2006 19:33:43 -0800
Message-Id: <1136345623.12190.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-01-03 at 22:26 +0100, Arjan van de Ven wrote:
> > Perhaps read/write on the character device file would be preferable to
> > ioctls for sending and receiving these management packets?  We don't
> > implement those file methods at the moment, so it's not like we'd be
> > displacing anything.
> 
> if it's just data packets.. you could implement a device that offers the
> SG_IO interface.

OK, thanks for the pointer.  I'll take a look.

	<b

