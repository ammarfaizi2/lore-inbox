Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265270AbTBBN5k>; Sun, 2 Feb 2003 08:57:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265275AbTBBN5j>; Sun, 2 Feb 2003 08:57:39 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:46986 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S265270AbTBBN5h>;
	Sun, 2 Feb 2003 08:57:37 -0500
Date: Sun, 2 Feb 2003 15:06:43 +0100
From: Jens Axboe <axboe@suse.de>
To: Gregoire Favre <greg@ulima.unil.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: is usb working under 2.5.59?
Message-ID: <20030202140643.GS31566@suse.de>
References: <20030202111657.GA31683@ulima.unil.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030202111657.GA31683@ulima.unil.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 02 2003, Gregoire Favre wrote:
> Hello,
> 
> I used to use usb under 2.4 with my Digital Ixus V with s10sh.
> It worked just perfectly, now under 2.5.59, I don't even see the output
> of a recongnize in the syslogd.
> 
> I have also tried gphoto2, which doesn't find any camera...

Check that you have ohci/uhci in addition to the ehci controller, I just
spent an hour finding out why 1.x devices didn't work on my via board
(thanks David :)...

-- 
Jens Axboe

