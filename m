Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272076AbRH3F3g>; Thu, 30 Aug 2001 01:29:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272073AbRH3F30>; Thu, 30 Aug 2001 01:29:26 -0400
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:59144 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S272016AbRH3F3J>;
	Thu, 30 Aug 2001 01:29:09 -0400
Date: Wed, 29 Aug 2001 22:27:31 -0700
From: Greg KH <greg@kroah.com>
To: Aaron Lehmann <aaronl@vitelus.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Diet /sbin/hotplug package released
Message-ID: <20010829222731.A14937@kroah.com>
In-Reply-To: <20010829120440.B12825@kroah.com> <20010829221246.B30945@vitelus.com> <20010829222206.B14791@kroah.com> <20010829222726.C30945@vitelus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010829222726.C30945@vitelus.com>; from aaronl@vitelus.com on Wed, Aug 29, 2001 at 10:27:26PM -0700
X-Operating-System: Linux 2.2.19 (i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2001 at 10:27:26PM -0700, Aaron Lehmann wrote:
> On Wed, Aug 29, 2001 at 10:22:06PM -0700, Greg KH wrote:
> > Why would POSIX "cleanness" matter for these scripts?
> 
> Believe it or not, some people don't use bash as /bin/sh, or at all.
> I notice that /etc/hotplug/hotplug.functions uses #!/bin/bash, which
> is better than pretending to be an "sh" script and using bashisms.

I realize that not all /bin/sh is really bash, that's why the scripts
explicitly ask for bash.  I'm guessing some bashisms are in there :)

thanks,

greg k-h
