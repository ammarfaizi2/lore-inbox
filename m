Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263172AbTJKAes (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 20:34:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263178AbTJKAes
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 20:34:48 -0400
Received: from mail.kroah.org ([65.200.24.183]:2692 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263172AbTJKAer (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 20:34:47 -0400
Date: Fri, 10 Oct 2003 16:56:13 -0700
From: Greg KH <greg@kroah.com>
To: Matt_Domsch@Dell.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: IBM Thinkpad A21 BIOS - EDD information wrong
Message-ID: <20031010235613.GI19046@kroah.com>
References: <1065735556.794.9.camel@iguana.domsch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1065735556.794.9.camel@iguana.domsch.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 09, 2003 at 04:39:11PM -0500, Matt_Domsch@Dell.com wrote:
> 
> /sys/firmware/edd/int13_dev80/raw_data
> int13 fn48 returned data:
> 
> 4a 00 01 00 ff 3f 00 00 10 00 00 00 3f 00 00 00         J...ÿ?......?...
> 00 53 a8 04 00 00 00 00 00 02 c6 00 40 00 dd be         .Sš.......Æ.@.ÝŸ
> 2c 00 00 00 50 43 49 20 41 54 41 20 20 20 20 20         ,...PCI ATA     
> 00 1f 07 00 00 00 00 00 00 00 00 00 00 00 00 00         ................
> 00 00 00 00 00 00 00 00 00 a1                           .........¡      

Hm, I thought you were going to use the sysfs binary file interface for
this file, instead of outputing a hex dump.  Any reason for keeping it
this way?

thanks,

greg k-h
