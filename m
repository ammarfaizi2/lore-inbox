Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261874AbTDHQGr (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 12:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261875AbTDHQGr (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 12:06:47 -0400
Received: from tomts10.bellnexxia.net ([209.226.175.54]:53949 "EHLO
	tomts10-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S261874AbTDHQGq (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 8 Apr 2003 12:06:46 -0400
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: 2.5.67-mm1
Date: Tue, 8 Apr 2003 12:18:22 -0400
User-Agent: KMail/1.5.9
Cc: akpm@digeo.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20030408042239.053e1d23.akpm@digeo.com> <200304080917.15648.tomlins@cam.org> <20030408083153.5dec0d0e.rddunlap@osdl.org>
In-Reply-To: <20030408083153.5dec0d0e.rddunlap@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200304081218.22598.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On April 8, 2003 11:31 am, Randy.Dunlap wrote:
> | This does not boot here.  I loop with the following message.
> |
> | i8042.c: Can't get irq 12 for AUX, unregistering the port.
> |
> | irq 12 is used (correctly) by my 20267 ide card.  My mouse is
> | usb and AUX is not used.
> |
> | Ideas?
>
> I guess that's due to my early kbd init patch.

Just to confirm, removing the above patch lets me 
boot just fine.

Thanks
Ed

