Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261872AbTJJTHS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 15:07:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262279AbTJJTHS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 15:07:18 -0400
Received: from hockin.org ([66.35.79.110]:43275 "EHLO www.hockin.org")
	by vger.kernel.org with ESMTP id S261872AbTJJTHP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 15:07:15 -0400
Date: Fri, 10 Oct 2003 11:56:09 -0700
From: Tim Hockin <thockin@hockin.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.7 thoughts
Message-ID: <20031010185609.GA4875@hockin.org>
References: <D9B4591FDBACD411B01E00508BB33C1B01F13BCE@mesadm.epl.prov-liege.be> <20031009115809.GE8370@vega.digitel2002.hu> <20031009165723.43ae9cb5.skraw@ithnet.com> <3F864F82.4050509@longlandclan.hopto.org> <20031010125137.4080a13b.skraw@ithnet.com> <3F86BD0E.4060607@longlandclan.hopto.org> <20031010143529.GT5112@vega.digitel2002.hu> <20031010144723.GC727@holomorphy.com> <20031010180320.GA1995@hockin.org> <20031010182909.GG727@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031010182909.GG727@holomorphy.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 10, 2003 at 11:29:09AM -0700, William Lee Irwin III wrote:
> I think there is some generalized cpu hotplug stuff that's gone in that
> direction already, though I don't know any details. The bits about non-
> cooperative offlining were very interesting to hear, though.

I spoke with Rusty about it at OLS.  I haven't tracked the hotplug CPU
projects.  I think that TASK_UNRUNNABLE is the sane way to handle said edge
case, but at the time Rusty was leaning towards SIGPOWER.


-- 
Notice that as computers are becoming easier and easier to use,
suddenly there's a big market for "Dummies" books.  Cause and effect,
or merely an ironic juxtaposition of unrelated facts?

