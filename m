Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268665AbUI3D5c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268665AbUI3D5c (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 23:57:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268683AbUI3D5c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 23:57:32 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:57513 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S268665AbUI3D53 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 23:57:29 -0400
Message-ID: <415B8531.3030406@sgi.com>
Date: Wed, 29 Sep 2004 23:01:53 -0500
From: Ray Bryant <raybry@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: alexn@telia.com, linux-kernel@vger.kernel.org
Subject: Re: lockmeter in 2.6.9-rc2-mm2
References: <41539FC1.7040001@sgi.com> <20040923212106.7a89b3af.akpm@osdl.org>
In-Reply-To: <20040923212106.7a89b3af.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Ray Bryant <raybry@sgi.com> wrote:
> 
>>This seems to compile for me, at least,
> 
> 
> Great.
> 
> 
>>haven't gotten to do a test of it.
> 
> 
> Please do.
> 
> 
>>Does the x86_64 stuff compile now?
> 
> 
> yup.  I do regular x86 and x86_64 allfooconfig builds.  I'd do so on
> sparc64/ppc64/ia64 too, if they had a chance of compiling :(
> 
> 
Andrew,

Just got around to testing lockmeter with 2.6.9-rc2-mm4.  It compiles
and works fine on i386, both in preempt and non-preempt kernels.

On Altix it compiles and boots fine, but hangs when you try to turn on
the lockmeter statististics (with "lockmeter on").  I'll pursue that
further tomorrow.
-- 
Best Regards,
Ray
-----------------------------------------------
                   Ray Bryant
512-453-9679 (work)         512-507-7807 (cell)
raybry@sgi.com             raybry@austin.rr.com
The box said: "Requires Windows 98 or better",
            so I installed Linux.
-----------------------------------------------

