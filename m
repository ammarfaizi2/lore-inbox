Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262808AbSLQAce>; Mon, 16 Dec 2002 19:32:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262812AbSLQAce>; Mon, 16 Dec 2002 19:32:34 -0500
Received: from air-2.osdl.org ([65.172.181.6]:28607 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262808AbSLQAce>;
	Mon, 16 Dec 2002 19:32:34 -0500
Subject: Re: [PATCH] kexec for 2.5.52 [OSDL PLM]
From: Andy Pfiffer <andyp@osdl.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <m1of7lahkn.fsf@frodo.biederman.org>
References: <m1smwxapdp.fsf@frodo.biederman.org>
	<1040066196.2183.2.camel@andyp>  <m1of7lahkn.fsf@frodo.biederman.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 16 Dec 2002 16:40:52 -0800
Message-Id: <1040085652.2263.80.camel@andyp>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-12-16 at 11:29, Eric W. Biederman wrote:

> > Is there a new kexec-tools package for this, or should the 1.8 rev
> > located here:
> > http://www.xmission.com/~ebiederm/files/kexec/
> > work okay?
> 
> 1.8 should work.

Okay.  Thanks.

> The old hwfixes should work as well.  If the .48 version does not
> patch cleanly holler.

The hwfixes for .48 applied cleanly for me, so I tossed the patches into
OSDL's PLM hopper:
http://www.osdl.org/cgi-bin/plm?module=patch_info&patch_id=1043
http://www.osdl.org/cgi-bin/plm?module=patch_info&patch_id=1042
http://www.osdl.org/cgi-bin/plm?module=patch_info&patch_id=1041
http://www.osdl.org/cgi-bin/plm?module=patch_info&patch_id=1038

Legend for those that don't want to click on the URLs:
a) PLM ID #1043: changes CONFIG_KEXEC to y by default (a quirk of the
PLM infrastructure).
b) PLM ID #1042: .48 hwfixes for kexec
c) PLM ID #1041: base kexec for 2.5.52
d) PLM ID #1038: base 2.5.52 kernel
e) OSDL PLM: http://www.osdl.org/cgi-bin/plm/

Andy




