Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751480AbWIUTQO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751480AbWIUTQO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 15:16:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751481AbWIUTQO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 15:16:14 -0400
Received: from mx1.redhat.com ([66.187.233.31]:3204 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751480AbWIUTQN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 15:16:13 -0400
Date: Thu, 21 Sep 2006 15:15:51 -0400
From: Dave Jones <davej@redhat.com>
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: Robin Getz <rgetz@blackfin.uclinux.org>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org,
       Greg KH <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>
Subject: Re: drivers/char/random.c exported interfaces
Message-ID: <20060921191551.GC17065@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Dmitry Torokhov <dtor@insightbb.com>,
	Robin Getz <rgetz@blackfin.uclinux.org>,
	"Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org,
	Greg KH <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>
References: <6.1.1.1.0.20060920125855.01eca0c0@ptg1.spd.analog.com> <200609210011.25891.dtor@insightbb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200609210011.25891.dtor@insightbb.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2006 at 12:11:25AM -0400, Dmitry Torokhov wrote:
 > On Wednesday 20 September 2006 13:04, Robin Getz wrote:
 > > Randy Dunlap said:
 > > >ISTM that we should at least fix the first 2 (by EXPORTing them).
 > > >or we don't allow INPUT=m.
 > > >
 > > >You want to send a patch?
 > > 
 > > No problem - which patch do you want? (exporting? or set INPUT to bool?)
 > > 
 > > I'll send the export later tonight if no objections.
 > >
 > 
 > Would there be any objections if I commit the patch below so input
 > could be built as a module? 

Under what circumstances is it desirable to allow INPUT=m ?
I'm having a hard time thinking of a usage scenario where it makes sense.

	Dave
