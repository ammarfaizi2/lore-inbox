Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267737AbUHMXh2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267737AbUHMXh2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 19:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267753AbUHMXh1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 19:37:27 -0400
Received: from mail.kroah.org ([69.55.234.183]:26775 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267737AbUHMXhQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 19:37:16 -0400
Date: Fri, 13 Aug 2004 16:27:40 -0700
From: Greg KH <greg@kroah.com>
To: John Lenz <jelenz@students.wisc.edu>
Cc: Andrew Zabolotny <zap@homelink.ru>, linux-kernel@vger.kernel.org
Subject: Re: Backlight and LCD module patches [2]
Message-ID: <20040813232739.GB5063@kroah.com>
References: <20040617223517.59a56c7e.zap@homelink.ru> <20040725215917.GA7279@hydra.mshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040725215917.GA7279@hydra.mshome.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 25, 2004 at 04:59:17PM -0500, John Lenz wrote:
> The problem I see is that we would like something like a bus to match  
> together class devices.  What would be really nice is something like  
> this.
> 
> struct class_match {
>  struct class *class1;
>  struct class *class2;
> 
>  int (*match)(struct class_device *dev1, struct class_device *dev2);
> };
> 
> This class match structure would be very similar to a bus, in that it  
> matches together two classes instead of matching a device to a driver.   
> All the class code would have to do is call the match function for all  
> possible combinations of class devices in class1 and in class2.  If  
> match returned true, then it would create symbolic links between the  
> two.

Care to provide a proposed implementation of this functionality?

thanks,

greg k-h
