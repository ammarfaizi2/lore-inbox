Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264728AbUD1K0t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264728AbUD1K0t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 06:26:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264732AbUD1K0s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 06:26:48 -0400
Received: from herkules.viasys.com ([194.100.28.129]:47833 "HELO
	mail.viasys.com") by vger.kernel.org with SMTP id S264728AbUD1K0q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 06:26:46 -0400
Date: Wed, 28 Apr 2004 13:26:34 +0300
From: Ville Herva <vherva@viasys.com>
To: Karim Yaghmour <karim@opersys.com>
Cc: ncunningham@linuxmail.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: What does tainting actually mean?
Message-ID: <20040428102634.GU23361@viasys.com>
Reply-To: vherva@viasys.com
References: <opr65eq9ncshwjtr@laptop-linux.wpcb.org.au> <408F4658.9050109@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <408F4658.9050109@opersys.com>
User-Agent: Mutt/1.4.1i
X-Operating-System: Linux herkules.viasys.com 2.4.25-rc2+mremap-unmap
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2004 at 01:51:20AM -0400, you [Karim Yaghmour] wrote:
> 
> Nigel Cunningham wrote:
> >What I mean is, how does it help to know that a kernel is tainted? When  
> >I'm working on Software Suspend and someone sends me an oops, I don't  
> >really care whether it's marked as tainted or not. For all I know, even 
> >if  it's not tainted, they may have thrown in half a dozen different 
> >patches  aside from Suspend, any one of which could be playing a role in 
> >the  appearance of the oops. It doesn't help me to know that the kernel 
> 
> The legal/moral implications of taint/binary-mods/etc. aside, I think it
> may be worth putting some thought into coming up with a way to identify
> which patches were applied to a kernel -- given the wide-spread use of this
> method to add/remove/amend kernel functionality. Maybe there should be a
> /proc/sys/kernel/patches file at runtime which would provide a list of
> applied patches and some characteristics/description? When patches are
> applied, there could then be a toplevel .patches file which all patch
> submitters/providers/distributors would be strongly encouraged or
> <form>insert your favorite coercive method or torture technique here</form>
> to amend as they add their code. At build time, the makefile could then
> use this file the generate some header used by the code printing out the
> /proc/sys/kernel/patches. At oops time, the content of this file would also
> be part of the dump.

It has been suggested before:

http://groups.google.com/groups?hl=en&lr=&ie=UTF-8&oe=UTF-8&threadm=linux.kernel.20020312114234.GF128921%40niksula.cs.hut.fi&rnum=1&prev=/groups%3Fhl%3Den%26lr%3D%26ie%3DUTF-8%26oe%3DUTF-8%26q%3D%2BRe%253A%2B%255Bmodule%252Fpatch%255D%2Boptional%2B%252Fproc%252Fpatches%2B%253F%253F%2B%26btnG%3DSearch

but it didn't exactly raise enormeous interest.


-- v -- 

v@iki.fi

