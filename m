Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261754AbULNXR2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261754AbULNXR2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 18:17:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261745AbULNXQi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 18:16:38 -0500
Received: from almesberger.net ([63.105.73.238]:8467 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S261754AbULNXPJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 18:15:09 -0500
Date: Tue, 14 Dec 2004 20:14:49 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] dynamic syscalls revisited
Message-ID: <20041214201449.A4527@almesberger.net>
References: <1101741118.25841.40.camel@localhost.localdomain> <20041129151741.GA5514@infradead.org> <Pine.LNX.4.53.0411291740390.30846@yvahk01.tjqt.qr> <cp2i3h$hs0$1@terminus.zytor.com> <1102370517.25841.216.camel@localhost.localdomain> <41B4DB1C.3060406@zytor.com> <1102372715.25841.227.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1102372715.25841.227.camel@localhost.localdomain>; from rostedt@goodmis.org on Mon, Dec 06, 2004 at 05:38:35PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:
> It can be easier to send the wrong command to a device, or even the
> wrong device than to use a wrong system call.  

So invent some /dev/syscall/<syscall-device-name> and you've reduced
this to good old clashes in a flat name space. You can hide all the
ugliness, sanity checking, etc. in a library.

I also think that a more direct approach for dynamic syscalls would
be nice, but the current status quo is far from unbearable.


- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
