Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262354AbULOOx6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262354AbULOOx6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 09:53:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262355AbULOOx6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 09:53:58 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:53640 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S262354AbULOOx5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 09:53:57 -0500
Message-ID: <41C04FFA.6010407@nortelnetworks.com>
Date: Wed, 15 Dec 2004 08:53:46 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Al Hooton <al@hootons.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: ioctl assignment strategy?
References: <1103067067.2826.92.camel@chatsworth.hootons.org> <20041215004620.GA15850@kroah.com>
In-Reply-To: <20041215004620.GA15850@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

> Minor one coming, why do you want to use an ioctl?  ioctls are generally
> frowned upon these days, and trying to add a new one is a tough and
> arduous process, that is not for the weak, or faint of heart.

Just curious--what other options would you suggest for arbitrary char devices to 
allow for control that doesn't fit nicely into the read/write paradigm?
