Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264602AbTLESM3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 13:12:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264855AbTLESM3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 13:12:29 -0500
Received: from slider.rack66.net ([212.3.252.135]:20126 "EHLO
	slider.rack66.net") by vger.kernel.org with ESMTP id S264602AbTLESMX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 13:12:23 -0500
Date: Fri, 5 Dec 2003 19:12:22 +0100
From: Filip Van Raemdonck <filipvr@xs4all.be>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux GPL and binary module exception clause?
Message-ID: <20031205181222.GA24882@debian>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20031205140304.GF17870@michonline.com> <001401c3bb56$3b2fdd40$ca41cb3f@amer.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001401c3bb56$3b2fdd40$ca41cb3f@amer.cisco.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 05, 2003 at 09:35:52AM -0800, Hua Zhong wrote:
> > So far, I don't see any reason why a module that uses an 
> > inline function provided via a kernel header could be distributed in
> > binary 
> > format without being a "derived work" and thus bound by the GPL.
> 
> Yeah, the same reason that XFS, NUMA, etc are derived works from Unix
> since they must include Unix header files.

Nope, they #include Linux header files - at least in their Linux version.
Even if one version does #include Unix headers, that does not mean
copyright to the rest of the code automatically belongs to the Unix
copyright holder.

And we're not even talking about source code; we're talking about
_binary modules_. Which do include object code which comes from GPLed
(inline) code; and are thus derived works.


Regards,

Filip

-- 
We have joy, we have fun,
we have Linux on our Sun.
