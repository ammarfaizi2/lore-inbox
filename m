Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262678AbTJNRum (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 13:50:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262681AbTJNRum
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 13:50:42 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:19134 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262678AbTJNRul
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 13:50:41 -0400
Message-ID: <3F8C3764.1070305@pobox.com>
Date: Tue, 14 Oct 2003 13:50:28 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Barry K. Nathan" <barryn@pobox.com>
CC: Jens Axboe <axboe@suse.de>, Pavel Machek <pavel@suse.cz>,
       Dave Jones <davej@redhat.com>, marcelo.tosatti@cyclades.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] laptop mode
References: <200310091103.h99B31ug014566@hera.kernel.org> <3F856A7E.2010607@pobox.com> <20031009140547.GD1232@suse.de> <20031009141734.GB23545@redhat.com> <20031009142632.GI1232@suse.de> <20031011114913.GA516@elf.ucw.cz> <20031011135943.GB1107@suse.de> <20031012224519.GA9043@ip68-4-255-84.oc.oc.cox.net>
In-Reply-To: <20031012224519.GA9043@ip68-4-255-84.oc.oc.cox.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Barry K. Nathan wrote:
> On Sat, Oct 11, 2003 at 03:59:43PM +0200, Jens Axboe wrote:
> 
>>Not very likely, imho. People have been using spin down with hdparm for
>>years (in Linux and elsewhere), while acoustic management is a bit more
>>esoteric.
> 
> 
> I'm having trouble finding this on Google now, but I've heard rumors
> over the years of old Fireball drives corrupting data if they receive
> write commands too soon after spinning up (i.e., the drive doesn't
> bother waiting to spin up fully first). Maybe I'm not remembering the
> details correctly, but it was something about the drive trying to act on
> commands before it was fully spun up and malfunctioning as a result.


Well, there exists devices which comply with the delayed spin-up part of 
ATA/ATAPI specification...   maybe our code doesn't cover that.  I don't 
put much stock in rumors, but they are occasionally clues... :)

	Jeff


