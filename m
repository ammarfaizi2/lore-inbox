Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262942AbUKYCz0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262942AbUKYCz0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 21:55:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262935AbUKYCz0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 21:55:26 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:17565 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262949AbUKYCyJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 21:54:09 -0500
Subject: Re: Suspend 2 merge: 34/51: Includes
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <E1CX6Pl-0002Gg-00@chiark.greenend.org.uk>
References: <1101292194.5805.180.camel@desktop.cunninghams>
	 <1101297843.5805.324.camel@desktop.cunninghams>
	 <20041124132558.GB13034@infradead.org>
	 <20041124132558.GB13034@infradead.org>
	 <1101327443.3425.11.camel@desktop.cunninghams>
	 <E1CX6Pl-0002Gg-00@chiark.greenend.org.uk>
Content-Type: text/plain
Message-Id: <1101350629.25030.9.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 25 Nov 2004 13:43:49 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Thu, 2004-11-25 at 10:19, Matthew Garrett wrote:
> Nigel Cunningham <ncunningham@linuxmail.org> wrote:
> 
> > I can see that it might look that way, but it's actually fundamental to
> > the support for building as modules (which is required for LVM &
> > encryption), and has been really helpful in creating clear distinctions
> > between the different parts of suspend. It also provides a clear method
> > for someone to add support for their new wizz-bang storage method or
> > compressor.
> 
> I'm not entirely clear on this. Surely all that's needed for LVM and
> encryption support is for that to be set up in userspace and then allow
> userspace to trigger a second attempt at resume? I have a hacky patch
> for swsusp that allows that (at the moment it just adds a "resume"
> method to /sys/power/state), which gives you the functionality without
> the module pain.

Yes, sorry. I'm confusing initrd/ramfs support with modules. You can
resume from an initrd/ramfs without building as modules.

Regardless, building support as modules does have the other advantages
noted above, and I haven't found adding support for building as modules
to be a pain at all.

Sorry again for confusing the issue.

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

You see, at just the right time, when we were still powerless, Christ
died for the ungodly.		-- Romans 5:6

