Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264185AbTEHAUO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 20:20:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264340AbTEHAUO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 20:20:14 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:1996 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S264185AbTEHAUM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 20:20:12 -0400
Date: Wed, 7 May 2003 17:32:23 -0700
From: Greg KH <greg@kroah.com>
To: Daniel Pittman <daniel@rimspace.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CPUFreq sysfs interface MIA?
Message-ID: <20030508003223.GA5051@kroah.com>
References: <873cjsv8hg.fsf@enki.rimspace.net> <20030506211210.GA3148@kroah.com> <87n0hzbnk6.fsf@enki.rimspace.net> <20030507233257.GA4481@kroah.com> <873cjqmgl6.fsf@enki.rimspace.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <873cjqmgl6.fsf@enki.rimspace.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 08, 2003 at 10:23:33AM +1000, Daniel Pittman wrote:
> On Wed, 7 May 2003, Greg KH wrote:
> > On Wed, May 07, 2003 at 10:36:09AM +1000, Daniel Pittman wrote:
> >> On Tue, 6 May 2003, Greg KH wrote:
> >> > On Tue, May 06, 2003 at 05:29:15PM +1000, Daniel Pittman wrote:
> >> >> 
> >> >> The content of /sys/devices/sys/cpu0 is:
> >> >> /sys/devices/sys/cpu0
> >> >> |-- name
> >> >> `-- power
> >> > 
> >> > What does /sys/class/cpu show?
> >> 
> >> /sys/class/cpu
> >> `-- cpu0
> >>     `-- device -> ../../../devices/sys/cpu0
> > 
> > Oops, forgot to hook up stuff... Does the following patch from
> > Jonathan Corbet fix this?
> 
> I tested this patch earlier and, no, it does not resolve the issue.
> I have exactly the same issue with it applied as before.

Hm, I just applied this patch, and dug up some hardware that will work
with cpufreq, and it shows up just fine for me.  I don't know what's
wrong, sorry.

greg k-h
