Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262965AbTHVAzV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 20:55:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262973AbTHVAzV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 20:55:21 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:42221 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262965AbTHVAzR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 20:55:17 -0400
Message-ID: <3F4569C9.2090404@pobox.com>
Date: Thu, 21 Aug 2003 20:54:33 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: rob@landley.net
CC: Jamie Lokier <jamie@shareable.org>,
       "Ihar 'Philips' Filipau" <filia@softhome.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: [PATCH] scsi.h uses "u8" which isn't defined.
References: <lRjc.6o4.3@gated-at.bofh.it> <20030820234810.GA24970@mail.jlokier.co.uk> <3F440C15.1050301@pobox.com> <200308212032.25334.rob@landley.net>
In-Reply-To: <200308212032.25334.rob@landley.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley wrote:
> On Wednesday 20 August 2003 20:02, Jeff Garzik wrote:
>>One way or another (direct inclusion, or via glibc-kernheaders pkg) the
>>headers today are GPL'd not LGPL'd... so I suppose it remains the realm
>>of lawyers...

> So I take it one of the goals of cleaned and pressed kernel-ABI headers for 
> 2.7 would be to have them distributable under LGPL?  (Just trying to be 
> explicit, here...)


Changing the status quo involves lots of pain:  querying every author if 
it's ok to change the license, and dealing with authors that don't want 
to change the license, or, rewriting the headers under a new license, etc.

I think it's best to do what we can from the technical perspective.

	Jeff



