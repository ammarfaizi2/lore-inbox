Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269144AbTHFNTa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 09:19:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270752AbTHFNTa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 09:19:30 -0400
Received: from main.gmane.org ([80.91.224.249]:20190 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S269144AbTHFNT3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 09:19:29 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: [Swsusp-devel] Re: [PATCH] Allow initrd_load() before
 software_resume() (version 2)
Date: Wed, 06 Aug 2003 15:16:19 +0200
Message-ID: <yw1xsmofvsd8.fsf@users.sourceforge.net>
References: <20030801002742.1033FE8003AE@mwinf0502.wanadoo.fr> <1059700691.1750.1.camel@laptop-linux>
 <20030801103054.9E75F30003B9@mwinf0201.wanadoo.fr>
 <1059734493.11684.0.camel@laptop-linux> <20030806113045.GB583@elf.ucw.cz>
 <1060170451.5848.2.camel@laptop.fenrus.com>
 <20030806125749.GA6875@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@main.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:lnJzHc2X0zCCXeUtDomrh13or8o=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> writes:

>> > > Okay. I hadn't tried it yet. I'll happily take up the barrow for you and
>> > > push it to Pavel and Linus with the rest, if you like.
>> > 
>> > Don't even think about that.
>> > 
>> > It is not safe to run userspace *before* doing resume. You don't want
>> > to see problems this would bring in. Forget it.
>> > 			
>> so how do you resume from a partition on a device mapper volume?
>> 
>> (and yes I basically agree with your sentiment though)
>
> I know very little about DM, its very well possible that resume from
> it is not supported.

Since DM requires some userspace program to set up the mappings, it
seems to me that it wouldn't work to resume from a DM volume.  I'd
much appreciate if it would work, somehow.

-- 
Måns Rullgård
mru@users.sf.net

