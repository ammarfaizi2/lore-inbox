Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268055AbTBMPBY>; Thu, 13 Feb 2003 10:01:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268056AbTBMPBX>; Thu, 13 Feb 2003 10:01:23 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:47208 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S268055AbTBMPBX>; Thu, 13 Feb 2003 10:01:23 -0500
To: suparna@in.ibm.com
Cc: Andy Pfiffer <andyp@osdl.org>, linux-kernel@vger.kernel.org,
       lkcd-devel@lists.sourceforge.net, fastboot@osdl.org
Subject: Re: [Fastboot] Re: Kexec on 2.5.59 problems ?
References: <3E45661A.90401@mvista.com> <m1d6m1z4bk.fsf@frodo.biederman.org>
	<20030210164401.A11250@in.ibm.com>
	<1044896964.1705.9.camel@andyp.pdx.osdl.net>
	<m13cmwyppx.fsf@frodo.biederman.org> <20030211125144.A2355@in.ibm.com>
	<1044983092.1705.27.camel@andyp.pdx.osdl.net>
	<1045007213.1959.2.camel@andyp.pdx.osdl.net>
	<m1k7g6xgs8.fsf@frodo.biederman.org>
	<1045089117.1502.5.camel@andyp.pdx.osdl.net>
	<20030213152033.A14278@in.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 13 Feb 2003 08:10:41 -0700
In-Reply-To: <20030213152033.A14278@in.ibm.com>
Message-ID: <m1d6lww70u.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suparna Bhattacharya <suparna@in.ibm.com> writes:

> Great !
> Eventually we should probably avoid init_mm altogether (on ppc64
> at least, init_mm can't be used as Anton pointed out to me) and
> setup a spare mm instead. 

What is the problem with init_mm?  Besides the fact that using it
is now failing?

Eric
