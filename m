Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263825AbUDPWG0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 18:06:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263886AbUDPWEJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 18:04:09 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:2434 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263876AbUDPWAR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 18:00:17 -0400
Date: Fri, 16 Apr 2004 23:00:14 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Dave Jones <davej@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       bfennema@falcon.csc.calpoly.edu
Subject: Re: Fix UDF-FS potentially dereferencing null
Message-ID: <20040416220014.GI24997@parcelfarce.linux.theplanet.co.uk>
References: <20040416214104.GT20937@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040416214104.GT20937@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2004 at 10:41:04PM +0100, Dave Jones wrote:
> Move size instantiation after null check for 'dir', nearer
> to where its first used.
 
Check in question is a BS - it never gets NULL passed as dir.
