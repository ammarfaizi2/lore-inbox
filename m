Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261761AbVEPRHF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261761AbVEPRHF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 13:07:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261765AbVEPRHE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 13:07:04 -0400
Received: from ns1.coraid.com ([65.14.39.133]:28496 "EHLO coraid.com")
	by vger.kernel.org with ESMTP id S261761AbVEPRGs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 13:06:48 -0400
To: Greg KH <greg@kroah.com>
Cc: "McMullan, Jason" <jason.mcmullan@timesys.com>, akpm@zip.com.au,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       PPC_LINUX <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH 2.6.11.7] ATA Over Ethernet Root, Mark 2
References: <1116011879.9050.92.camel@jmcmullan.timesys>
	<20050514072826.GB20021@kroah.com>
	<1116249602.9050.105.camel@jmcmullan.timesys>
	<20050516162011.GA8716@kroah.com>
From: Ed L Cashin <ecashin@coraid.com>
Date: Mon, 16 May 2005 13:03:22 -0400
In-Reply-To: <20050516162011.GA8716@kroah.com> (Greg KH's message of "Mon,
 16 May 2005 09:20:11 -0700")
Message-ID: <87wtpz5cit.fsf@coraid.com>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> writes:

> On Mon, May 16, 2005 at 09:14:02AM -0400, McMullan, Jason wrote:
...
[gregkh writes]
>> > Also, please CC the aoe maintainer, that's documented in
>> > Documentation/SubmittingPatches :)
>> 
>>   I did to support@coraid.com, in a separate message.
>
> That's not the email address listed in MAINTAINERS, is it?

I did get it, though.  I didn't realize that the reason for the patch
is for use on systems that have so little RAM that they can't have an
initrd.

It seems like the system will hang forever with no diagnostics if the
root device isn't found.  Perhaps an error message would be helpul?

I do wonder whether the problem this patch solves might be a special
case that doesn't merit the extra complexity of a Kconfig knob.  It is
certainly a useful patch for some users, but I don't know how many.

-- 
  Ed L Cashin <ecashin@coraid.com>

