Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261704AbVBWXXc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261704AbVBWXXc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 18:23:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261688AbVBWXU2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 18:20:28 -0500
Received: from mail.kroah.org ([69.55.234.183]:49042 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261689AbVBWXSE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 18:18:04 -0500
Date: Wed, 23 Feb 2005 15:17:47 -0800
From: Greg KH <greg@kroah.com>
To: linux-os <linux-os@analogic.com>
Cc: Mickey Stein <yekkim@pacbell.net>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [i2c]: Fix some gcc 4.0 compile failures and warnings
Message-ID: <20050223231747.GB6500@kroah.com>
References: <421CFFDC.90806@pacbell.net> <Pine.LNX.4.61.0502231738590.5509@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0502231738590.5509@chaos.analogic.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2005 at 05:57:14PM -0500, linux-os wrote:
> On Wed, 23 Feb 2005, Mickey Stein wrote:
> 
> >From: Mickey Stein
> >Versions:   linux-2.6.11-rc4-bk11, gcc4 (GCC) 4.0.0 20050217 (latest fc 
> >rawhide from 19Feb DL)
> >
> >gcc 4.0.x cvs seems to dislike "include/linux/i2c.h file" and others due 
> >to a current gcc 4.0.x change having to do with
> >array declarations.
> >
> >Example error msg:   include/linux/i2c.h:{55,194} error: array type has 
> >incomplete element type
> >
> >A. Daplas has recently done a workaround for this on another header file. 
> >A thread discussing this
> >can be found by following the link below:
> >
> >http://gcc.gnu.org/ml/gcc/2005-02/msg00053.html
> >
> 
> Do you know if the new compiler will compile....
> 
> int main(int argc, char *argv[]){}
> 
> ?????

That's not the point here.  See the above thread for the real point.

greg k-h
