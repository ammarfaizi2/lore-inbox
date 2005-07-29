Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262829AbVG2X4i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262829AbVG2X4i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 19:56:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262831AbVG2X4h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 19:56:37 -0400
Received: from zproxy.gmail.com ([64.233.162.207]:58484 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262941AbVG2Xyb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 19:54:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=t/Fm3apwwYoRavzaZhoT9CmkwwgnpN/UBJuTzPNvzK+gLJtm5ttd/A9wTYCl5kMGHmIbZWLlpG1S0IBEOg95cRKlc7cw2BEnudom9/oj/LbYdrCiKwQAFat016xa4MnvSewg7OXSe1jWZaT7ARJmLdwxawlzJbkjObTAXfHX9FA=
Message-ID: <88e823ff0507291654ebe2407@mail.gmail.com>
Date: Fri, 29 Jul 2005 17:54:29 -0600
From: Brad Davis <enrock@gmail.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: US Robotics (Hardware) Modem Not Detected
In-Reply-To: <88e823ff050727074411651351@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <88e823ff0507270645613b1ca@mail.gmail.com>
	 <20050727145747.A29785@flint.arm.linux.org.uk>
	 <88e823ff050727074411651351@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/05, Brad Davis <enrock@gmail.com> wrote:
> On 7/27/05, Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> > serial8250_init does not contain any such message, so you're not
> > running a mainline kernel, but some patched version.  Are these
> > patches available somewhere?
> 
> I'm compiling from the Ubuntu (based on Debian) sources. I'll either
> download a clean kernel source tonight and try it out or try remove
> the patches to the serial driver and try that.
> 
OK. I got the modem working. I used the Ubuntu sources (2.6.10), but
replaced the serial driver code with the pristine code from 2.6.10.
I'll have to follow up with the debian or ubuntu people.

Thanks for the help, and sorry to have bothered you with a
distribution specific issue.

Brad
-- 
enrock@gmail.com
