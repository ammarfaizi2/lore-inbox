Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261692AbTIRP51 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 11:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261737AbTIRP51
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 11:57:27 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:49301 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S261692AbTIRP50
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 11:57:26 -0400
Date: Thu, 18 Sep 2003 16:56:52 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Dave Jones <davej@redhat.com>, Pavel Machek <pavel@ucw.cz>,
       richard.brunner@amd.com, alan@lxorguk.ukuu.org.uk, davidsen@tmr.com,
       zwane@linuxpower.ca, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
Message-ID: <20030918155652.GB7548@mail.jlokier.co.uk>
References: <99F2150714F93F448942F9A9F112634C0638B1DE@txexmtae.amd.com> <20030918074331.GA386@elf.ucw.cz> <20030918140509.GM8764@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030918140509.GM8764@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
>  > they should read /proc/cpuinfo exactly because this kind of errata.
> 
> We don't do any change to /proc/cpuinfo in this case. As I mentioned
> in an earlier mail, the only way you could disable prefetch in this way
> would be by reporting the entire sse/3dnow instruction sets as unavailable
> which is overkill.

If you're running a *specifically non-AMD* kernel on an Athlon (that's
what this strand of the thread is about), is it a big deal to report
sse/3dnow as unavailable?  Presumably if you want sse/3dnow to be
reported on AMDs, you can just run a generic or AMD-enabled kernel.

-- Jamie
