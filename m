Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262865AbVAFPcJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262865AbVAFPcJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 10:32:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262878AbVAFPcJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 10:32:09 -0500
Received: from orb.pobox.com ([207.8.226.5]:35985 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S262865AbVAFPbc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 10:31:32 -0500
Date: Thu, 6 Jan 2005 07:31:18 -0800
From: "Barry K. Nathan" <barryn@pobox.com>
To: Dave Jones <davej@redhat.com>, William Lee Irwin III <wli@holomorphy.com>,
       Bill Davidsen <davidsen@tmr.com>, "L. A. Walsh" <law@tlinx.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Reviving the concept of a stable series (was Re: starting with 2.7)
Message-ID: <20050106153118.GA2390@ip68-4-98-123.oc.oc.cox.net>
References: <41D91707.6040102@tlinx.org> <41D9C53A.3030503@tmr.com> <20050104130846.GD2708@holomorphy.com> <20050104182017.GE19167@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050104182017.GE19167@redhat.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2005 at 01:20:17PM -0500, Dave Jones wrote:
> So now we're at our 2.6.9-ac+a few dozen 2.6.10 csets
> and all is happy with the world. Except for the regressions.
> As an example, folks upgrading from Fedora core 2, with its
> 2.6.8 kernel found that ACPI no longer switched off their
> machines for example. Much investigation went into
> trying to pin this down. Kudos to Len Brown and team for
> spending many an hour staring into bug reports on this
> issue, but ultimately the cause was never found.
> It was noted by several of our users seeing this problem
> that 2.6.10 no longer exhibits this flaw.  Yet our
> 2.6.9-ac+backports+every-2.6.10-acpi-cset also was broken.
> It's likely Fedora will get a 2.6.10 based update before
> the fault is ever really found for a 2.6.9 backport.

I just did some experimentation on one of my boxes. For me the ACPI
shutdown problem:

+ does not happen on mainline 2.6.9
+ does not happen on 2.6.9-ac16
+ does happen on 2.6.9-1.724_FC3
+ does not happen on mainline 2.6.10
+ does not happen on 2.6.10-1.727_FC3

Just mentioning it for whatever relevance it may have to this debate,
and in case it helps find a fix. (I'll see if I can narrow things down
any further.)

-Barry K. Nathan <barryn@pobox.com>

