Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261485AbTISKPw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 06:15:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261486AbTISKPw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 06:15:52 -0400
Received: from main.gmane.org ([80.91.224.249]:56706 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261485AbTISKPu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 06:15:50 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: Resuming from software suspend
Date: Fri, 19 Sep 2003 12:15:12 +0200
Message-ID: <yw1xoexhkrtb.fsf@users.sourceforge.net>
References: <1063915370.2410.12.camel@laptop-linux> <yw1xad91nrmd.fsf@users.sourceforge.net>
 <1063958370.5520.6.camel@laptop-linux>
 <yw1xu179mc55.fsf@users.sourceforge.net>
 <1063963914.7253.9.camel@laptop-linux>
 <yw1xwuc5kt7e.fsf_-_@users.sourceforge.net>
 <1063965939.7874.6.camel@laptop-linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:Yukm9K75YwR72uBxt6Xo3ipWifs=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Cunningham <ncunningham@clear.net.nz> writes:

> If your filesystems were mounted readonly and the boot won't mount them
> writable, you should be fine with no special precautions. Last time I
> looked at 2.6 code, it didn't fix the suspend header when you use
> noresume. If that's still true, you should be able to boot with the
> noresume option, and then later normally.

What I want to do is boot, do some things, and then resume the
suspended state without rebooting between.  Is that possible?  I don't
see any reason why it should be impossible to do, even if it's not
currently supported.

-- 
Måns Rullgård
mru@users.sf.net

