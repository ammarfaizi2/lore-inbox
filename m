Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267370AbUJRSY6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267370AbUJRSY6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 14:24:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267334AbUJRSYK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 14:24:10 -0400
Received: from mx1.redhat.com ([66.187.233.31]:5763 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267326AbUJRSWz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 14:22:55 -0400
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>,
       Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: forcing PS/2 USB emulation off
References: <orzn2lyw8k.fsf@livre.redhat.lsd.ic.unicamp.br>
	<20041017225733.GA25435@kroah.com>
From: Alexandre Oliva <aoliva@redhat.com>
Organization: Red Hat Global Engineering Services Compiler Team
Date: 18 Oct 2004 15:22:37 -0300
In-Reply-To: <20041017225733.GA25435@kroah.com>
Message-ID: <orfz4bdgya.fsf@livre.redhat.lsd.ic.unicamp.br>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 17, 2004, Greg KH <greg@kroah.com> wrote:

> On Sun, Oct 17, 2004 at 04:34:35PM -0300, Alexandre Oliva wrote:
>> 
>> Here's Vojtech's patch, updated to 2.6.9-rc4-bk2-ish (Fedora Core
>> kernel-2.6.8-1.624).  Is there a good reason to keep it out of the
>> base kernel?

> It's already in the -mm kernels, and will be sent to Linus after 2.6.9
> is out.  If you could test that kernel and verify that it works for this
> situation, I would appreciate it.

Cool!  It works, as far as enabling the kernel to see there's a mouse
there.  Unfortunately, it doesn't recognize it as an ALPS touchpad,
just as a regular PS/2 mouse.  I haven't tried to figure out why yet.

-- 
Alexandre Oliva             http://www.ic.unicamp.br/~oliva/
Red Hat Compiler Engineer   aoliva@{redhat.com, gcc.gnu.org}
Free Software Evangelist  oliva@{lsd.ic.unicamp.br, gnu.org}
