Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261477AbUK1OUy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261477AbUK1OUy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 09:20:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261484AbUK1OUy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 09:20:54 -0500
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:59761 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S261477AbUK1OUu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 09:20:50 -0500
Message-ID: <41A9DEB1.5000309@microgate.com>
Date: Sun, 28 Nov 2004 08:20:33 -0600
From: Paul Fulghum <paulkf@microgate.com>
User-Agent: Mozilla Thunderbird 0.9 (Windows/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pete Zaitcev <zaitcev@redhat.com>
CC: greg@kroah.com, linux-usb-devel@lists.sourceforge.net, rwhite@casabyte.com,
       linux-kernel@vger.kernel.org, kingst@eecs.umich.edu,
       Oleksiy@kharkiv.com.ua, reg@dwf.com, clemens@dwf.com
Subject: Re: Little rework of usbserial in 2.4
References: <20041127173558.4011b177@lembas.zaitcev.lan>
In-Reply-To: <20041127173558.4011b177@lembas.zaitcev.lan>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete Zaitcev wrote:
> Not done #1: I asked Paul Fulghum to experiment with dropping a private
> implementation of write callback from pl2303 and have Oleksy to test it.
> I guess I have to do it myself some time.

When you originally did not respond to my last post of 11/2
(which you did yesterday) I assumed you
did not wish to be pestered with that issue.

I will make a patch to drop the private implementation.
Oleksy must do the testing, as I do not have that hardware.

This approach will not fix other devices that have private
write callback implementations which do not implement the new
write throttling protocol.

--
Paul Fulghum
paulkf@microgate.com
