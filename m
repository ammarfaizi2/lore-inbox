Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261159AbUFMUma@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbUFMUma (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jun 2004 16:42:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261162AbUFMUm3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jun 2004 16:42:29 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:45711 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S261159AbUFMUm2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jun 2004 16:42:28 -0400
Subject: Re: sys_close undefined on x86_64
From: John Stebbins <john@stebbins.name>
Reply-To: john@stebbins.name
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040613002814.GC29873@kroah.com>
References: <1087085478.7036.13.camel@Homer>
	 <20040613002814.GC29873@kroah.com>
Content-Type: text/plain
Organization: Home
Message-Id: <1087159346.2961.5.camel@Homer>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 13 Jun 2004 13:42:26 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the pointer.  I hadn't heard about the firmware download
subsystem.  I just had a look.  Seems to be just the thing needed here.
There are other people actively working on this module, so maybe I can
get it done by just suggesting it to them :->

John

On Sat, 2004-06-12 at 17:28, Greg KH wrote:
> On Sat, Jun 12, 2004 at 05:11:18PM -0700, John Stebbins wrote:
> > 
> > insmod fails with sys_close undefined message when attempting to load
> > the module.
> 
> Why would a kernel module want to call sys_close directly?  If it's for
> firmware loading, the module needs to be ported to use the firmware
> download subsystem.
> 
> Good luck,
> 
> greg k-h

