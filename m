Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968450AbWLEQx0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968450AbWLEQx0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 11:53:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968456AbWLEQx0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 11:53:26 -0500
Received: from coyote.holtmann.net ([217.160.111.169]:53369 "EHLO
	mail.holtmann.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968450AbWLEQxZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 11:53:25 -0500
Subject: Re: [PATCH 0/3] New firewire stack
From: Marcel Holtmann <marcel@holtmann.org>
To: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
Cc: linux-kernel@vger.kernel.org, Stefan Richter <stefanr@s5r6.in-berlin.de>
In-Reply-To: <45758CB3.80701@redhat.com>
References: <20061205052229.7213.38194.stgit@dinky.boston.redhat.com>
	 <1165308400.2756.2.camel@localhost>  <45758CB3.80701@redhat.com>
Content-Type: text/plain
Date: Tue, 05 Dec 2006 16:30:50 +0100
Message-Id: <1165332650.2756.27.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kristian,

> >> I'm announcing an alternative firewire stack that I've been working on
> >> the last few weeks.  I'm aiming to implement feature parity with the
> ...
> > can you please use drivers/firewire/ if you want to start clean or
> > aiming at replacing drivers/ieee1394/. Using "fw" as an abbreviation in
> > the directory path is not really helpful.
> 
> Yes, that's probably a better idea.  Do you see a problem with using fw_* as a 
> prefix in the code though?  I don't see anybody using that prefix, but Stefan 
> pointed out to me that it's often used to abbreviate firmware too.

the only problem are public and exported interfaces and function. For
static code you can use whatever you want. I personally would go with
"ieee1394", because that is the official name for it. Otherwise go with
"firewire" if you wanna separate yourself from the previous stack.

Besides having "fw" for firmware it also is used in terms of firewall
and you don't wanna have that confusion.

Regards

Marcel


