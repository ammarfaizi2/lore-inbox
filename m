Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266901AbUAXKKj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 05:10:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266902AbUAXKKi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 05:10:38 -0500
Received: from main.gmane.org ([80.91.224.249]:36064 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S266901AbUAXKKc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 05:10:32 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: 2.6.1 + XFS wierdness
Date: Sat, 24 Jan 2004 11:03:25 +0100
Message-ID: <yw1xhdyl7jf6.fsf@ford.guide>
References: <8D2C6B0D-21C8-11B2-9DDD-000A958B60EE__36670.0378632688$1074934610@runbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:VckBSVnVcGsYMlCN/aymHqHC+QQ=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Igor <ivi@runbox.com> writes:

> Ok, as advised I'm reporting what happened to my system:
> I run Kernel 2.6.1 with XFS on a laptop, I forgot to send it to "sleep"
> and battery died, so there was unclean unmount (This is, what I
> believe was the cause),
> at some point after I restarted my system many of the files couldn't
> be executed:
> "binary file can't be executed reported", However the system was
> functional and I could boot it.
> So I hexopened some of the problematic files and found that although
> the size of the file is maintained, there was no data, every byte was
> replaced by 0, I guess it was lucking reference on a hard drive or
> maybe something else. The reason I think the root of the problem is
> filesystem + kernel because the "corrupted" files have nothing in
> common, e.g:
> /usr/bin/file
> /etc/init.d/cron
> /usr/bin/lynx
> and that only happened when I updated kernel to 2.6.1

See http://oss.sgi.com/projects/xfs/faq.html#nulls

-- 
Måns Rullgård
mru@kth.se

