Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265350AbUAYWsa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 17:48:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265351AbUAYWsa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 17:48:30 -0500
Received: from d213-103-156-147.cust.tele2.ch ([213.103.156.147]:3394 "EHLO
	kameha") by vger.kernel.org with ESMTP id S265350AbUAYWs2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 17:48:28 -0500
Message-ID: <401447C1.6020902@freesurf.ch>
Date: Sun, 25 Jan 2004 23:48:33 +0100
From: Marc Mongenet <Marc.Mongenet@freesurf.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net, tranter@pobox.com
Subject: Re: 2.4.25pre7 - cannot mount 128MB vfat fs on Minolta camera
References: <4013D155.3080900@freesurf.ch> <87y8rw2eyy.fsf@devron.myhome.or.jp> <40140221.40901@freesurf.ch> <87isiz3luw.fsf@devron.myhome.or.jp> <20040125214625.GB28000@kroah.com>
In-Reply-To: <20040125214625.GB28000@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

> Marc Mongenet <Marc.Mongenet@freesurf.ch> writes:
>> Hi, I have a Minolta DiMAGE F100 camera and two memory cards,
>> a 16 MB and a 128 MB.
 >> So, I can mount the 16 MB card or the 128 MB card with any kernel,
 >> BUT I have to reboot the system when I change the cards. Example:

> Yes, run 'eject' after removing the media before inserting the new
> media.  That should fix the problem.

Fixed.
It does not seem to be well known.
I suggest to add this information in the eject documentation.

Thanks,
Marc Mongenet
