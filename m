Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263605AbTKQRwT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 12:52:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263607AbTKQRwS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 12:52:18 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:52697 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S263605AbTKQRwR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 12:52:17 -0500
Message-ID: <3FB90A6A.4050505@nortelnetworks.com>
Date: Mon, 17 Nov 2003 12:50:34 -0500
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>,
       Andrey Borzenkov <arvidjaar@mail.ru>, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Is initramfs freed after kernel is booted?
References: <E1ALlQs-000769-00.arvidjaar-mail-ru@f7.mail.ru> <3FB8EBC2.1080800@nortelnetworks.com> <3FB8ED91.3050305@backtobasicsmgmt.com> <3FB8F218.30601@nortelnetworks.com> <20031117172557.GX24159@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

viro@parcelfarce.linux.theplanet.co.uk wrote:
> On Mon, Nov 17, 2003 at 11:06:48AM -0500, Chris Friesen wrote:

>>Anyone know why it overmounts rather than pivots?

> Because amount of extra code you lose that way takes more memory than
> empty roots takes.
> 
> Remove whatever files you don't need and be done with that.

How do you remove files from the old rootfs after the new one has been 
mounted on top of it?

Chris



-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

