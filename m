Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265959AbUGEIFi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265959AbUGEIFi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 04:05:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265960AbUGEIFf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 04:05:35 -0400
Received: from postfix4-1.free.fr ([213.228.0.62]:34262 "EHLO
	postfix4-1.free.fr") by vger.kernel.org with ESMTP id S265959AbUGEIFe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 04:05:34 -0400
From: Duncan Sands <baldrick@free.fr>
To: Clemens Schwaighofer <cs@tequila.co.jp>
Subject: Re: procfs permissions on 2.6.x
Date: Mon, 5 Jul 2004 10:05:29 +0200
User-Agent: KMail/1.6.2
Cc: viro@parcelfarce.linux.theplanet.co.uk, Andrew Morton <akpm@osdl.org>,
       hch@infradead.org, linux-kernel@vger.kernel.org,
       olaf+list.linux-kernel@olafdietsche.de
References: <20040703202242.GA31656@MAIL.13thfloor.at> <20040704221302.GW12308@parcelfarce.linux.theplanet.co.uk> <40E8B3DB.5010402@tequila.co.jp>
In-Reply-To: <40E8B3DB.5010402@tequila.co.jp>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407051005.29968.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Well perhaps I am on the wrong track but eg /proc/bus/usb/002/005 is my
> digital camera and unless its either world rw or owned by me (user) I
> can't get any pictures unless I make myself root.
> 
> So yes, I would want to have chown/chmod in procfs ...

Hi Clemens, that isn't procfs, it's usbfs.  It's been plonked (*) on top of a procfs
directory, but that doesn't matter.

Ciao,

Duncan.

(*)  I believe the technical term is "mounted".
