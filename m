Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261879AbTIYLIG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 07:08:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261882AbTIYLIG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 07:08:06 -0400
Received: from main.gmane.org ([80.91.224.249]:30636 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261879AbTIYLIE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 07:08:04 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: linux/time.h annoyance
Date: Thu, 25 Sep 2003 13:07:25 +0200
Message-ID: <yw1xisnhyvma.fsf@users.sourceforge.net>
References: <1064483200.6405.442.camel@shrek.bitfreak.net> <20030925105436.A8809@infradead.org>
 <1064485031.2220.468.camel@shrek.bitfreak.net>
 <20030925112326.A9412@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:xP/meUuoIS82UGZj7ebhcYd+cxs=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> writes:

>> linux/videodev2.h includes linux/time.h. And I need linux/videodev2.h in
>> my application, there is no sys/ equivalent. I expect there's more of
>> such cases.
>> 
>> I also explained this in my first email. ;).
>
> So fix your copy of linux/videdev2.h to not include linux/time.h.
>
> If you ask Gerd nicely he might even include that change in the kernel
> version so don't have to keep a delta.

I've been wondering for some time if I was the only one to see these
types of errors.  There are other headers having the same problems,
but I can't remember which ones right now.

-- 
Måns Rullgård
mru@users.sf.net

