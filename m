Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264379AbTLPXlJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 18:41:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264377AbTLPXlI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 18:41:08 -0500
Received: from mail.mediaways.net ([193.189.224.113]:32916 "HELO
	mail.mediaways.net") by vger.kernel.org with SMTP id S264379AbTLPXlE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 18:41:04 -0500
Subject: Re: essid any -> orinoco_lock() called with hw_unavailable -test11
From: Soeren Sonnenburg <kernel@nn7.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1071617600.734.44.camel@gaston>
References: <1071571879.2498.65.camel@localhost>
	 <1071617600.734.44.camel@gaston>
Content-Type: text/plain
Message-Id: <1071618039.2844.19.camel@localhost>
Mime-Version: 1.0
Date: Wed, 17 Dec 2003 00:40:40 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-12-17 at 00:33, Benjamin Herrenschmidt wrote:
> On Tue, 2003-12-16 at 21:51, Soeren Sonnenburg wrote:
> > Hi.
> > 
> > I get quiete many error messages in when I do
> > 
> > ifconfig eth1 192.168.0.1 up
> > iwconfig eth1 mode ad-hoc
> > iwconfig eth1 nick bla
> > iwconfig eth1 key off
> > iwconfig eth1 essid "any"
> > ifconfig eth1 down
> > 
> > and no wireless network is available. The device is no longer accessible
> > afterwards. Reloading kernel modules helps, however if I go to sleep
> > mode on this 1GHz 15" G4 Powerbook the machine hangs on resume, see
> > 
> > http://www.nn7.de/kernel/essid_any.jpg
> > 
> > for the messages and xmon trace (please use a webbrowser to view it, it
> > is a redirect)
> 
> Which test11 ? Did you try my tree ?
> 
> (ppc.bkbits.net/linuxppc-2.5-benh via bitkeeper, rsync mirror on
> source.mvista.com)

Sorry yes, your tree. rsynced yesterday from source.mvista.com.

Soeren.

