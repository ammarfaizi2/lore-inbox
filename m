Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278297AbRJ1WXT>; Sun, 28 Oct 2001 17:23:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277313AbRJ1WXJ>; Sun, 28 Oct 2001 17:23:09 -0500
Received: from ibis.worldnet.net ([195.3.3.14]:13075 "EHLO ibis.worldnet.net")
	by vger.kernel.org with ESMTP id <S278297AbRJ1WXB>;
	Sun, 28 Oct 2001 17:23:01 -0500
Message-ID: <3BDC8565.ADCD6FD0@worldnet.fr>
Date: Sun, 28 Oct 2001 23:23:33 +0100
From: Laurent Deniel <deniel@worldnet.fr>
Organization: Home
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en, fr
MIME-Version: 1.0
To: Mark Hahn <hahn@physics.mcmaster.ca>
CC: linux-kernel@vger.kernel.org
Subject: Re: Ethernet NIC dual homing
In-Reply-To: <Pine.LNX.4.10.10110281248320.5138-100000@coffee.psychology.mcmaster.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Hahn wrote:
> 
> > the kernel switches to the second NIC. Such a similar feature exists in
> 
> why not user-space?

Good question. The switch could be initiated by a user-space daemon but 
the switch itself should be implemented at kernel level for performance 
and atomicity reasons (to avoid too many loss of packets) ?
