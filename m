Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288864AbSAIGMa>; Wed, 9 Jan 2002 01:12:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288866AbSAIGMU>; Wed, 9 Jan 2002 01:12:20 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:8975 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S288864AbSAIGME>;
	Wed, 9 Jan 2002 01:12:04 -0500
Date: Tue, 8 Jan 2002 22:09:51 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] klibc requirements
Message-ID: <20020109060951.GA18024@kroah.com>
In-Reply-To: <20020108192450.GA14734@kroah.com> <20020109042331.GB31644@codeblau.de> <20020109045109.GA17776@kroah.com> <a1giqs$93d$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1giqs$93d$1@cesium.transmeta.com>
User-Agent: Mutt/1.3.25i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Wed, 12 Dec 2001 03:53:43 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2002 at 09:01:16PM -0800, H. Peter Anvin wrote:
> 
> Why should it be included in the kernel image?  That's not the current
> plan, as far as I know.  It should be a separate file or set of files
> loaded by the bootloader (using an enhanced initrd protocol backward
> compatible with old bootloaders.)

Hm, missed those messages.  I remember talk of adding the initramfs
image to the kernel image itself, which keeps from having to change any
bootloaders.  But if this has changed, that's ok with me.

Is any of this written down all in one place?

> Of course, it might be convenient
> to have them come out of the same source distribution, but that's
> really an unrelated issue.

If the files contain kernel modules, they need to come out of the same
source distribution :)

thanks,

greg k-h
