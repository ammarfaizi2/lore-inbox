Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267343AbUGNJuW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267343AbUGNJuW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 05:50:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267344AbUGNJuW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 05:50:22 -0400
Received: from gate.corvil.net ([213.94.219.177]:35594 "EHLO corvil.com")
	by vger.kernel.org with ESMTP id S267343AbUGNJuU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 05:50:20 -0400
Message-ID: <40F50181.7070900@draigBrady.com>
Date: Wed, 14 Jul 2004 10:48:49 +0100
From: P@draigBrady.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040124
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>
CC: Jeff Garzik <jgarzik@pobox.com>, Ricky Beam <jfbeam@bluetronic.net>,
       "Eric D. Mudama" <edmudama@bounceswoosh.org>,
       "Robert M. Stockmann" <stock@stokkie.net>, linux-kernel@vger.kernel.org
Subject: Re: SATA disk device naming ?
References: <20040713064645.GA1660@bounceswoosh.org> <Pine.GSO.4.33.0407131221000.25702-100000@sweetums.bluetronic.net> <20040713164911.GA947@havoc.gtf.org> <20040713223541.GB7980@taniwha.stupidest.org>
In-Reply-To: <20040713223541.GB7980@taniwha.stupidest.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood wrote:
> On Tue, Jul 13, 2004 at 12:49:11PM -0400, Jeff Garzik wrote:
> 
> 
>>For LABEL to work on root filesystem, you need an initrd.
> 
> 
> initrd is such a PITA at times, I wondered about something hacky like
> sticking LABEL parsing for rootfs (marked init) into the kernel but
> it's really gross.
> 
> Ideally the initrd/initramfs process just needs better (userspace)
> infrastructure to make it more reliable/easier.

Something like this?
http://www-124.ibm.com/pipermail/evms/2001-March/000119.html

initrd is awkward but I've found I need the flexibility.
For e.g. I modified nash to support an index as well as
a label so one could have multiple redundant filesystem
images to choose from.

Pádraig.
