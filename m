Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265804AbUFOSJu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265804AbUFOSJu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 14:09:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265808AbUFOSJt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 14:09:49 -0400
Received: from tor.morecom.no ([64.28.24.90]:59091 "EHLO tor.morecom.no")
	by vger.kernel.org with ESMTP id S265804AbUFOSJj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 14:09:39 -0400
Subject: Re: mode data=journal in ext3. Is it safe to use?
From: Petter Larsen <pla@morecom.no>
To: ext3 <ext3-users@redhat.com>
Cc: ext3@philwhite.org, Nicolas.Kowalski@imag.fr, linux-kernel@vger.kernel.org
In-Reply-To: <40FB8221D224C44393B0549DDB7A5CE83E31B1@tor.lokal.lan>
References: <40FB8221D224C44393B0549DDB7A5CE83E31B1@tor.lokal.lan>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1087322976.1874.36.camel@pla.lokal.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 15 Jun 2004 20:09:37 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I try again.

Can anybody of you acknowledge or not if mode data=journal in ext3 is
safe to use in Linux kernel 2.6.x?

Wee need to have a very consistent and integrity for our filesystem, and
it would then be desired to journal both data and metadata.

But if this mode can corrupt the filesystem as both Phil White and
Nicolas Kowalski has experienced, it may be more advised to use mode
data=ordered instead.

Data integrity is much more important for us than speed.

What do you people out there say?

I also try to post this in the kernel mailing list. I have not
subscribed to the kml so if anybody there have som advisory about this I
would be pleased if you could CC me.

Petter
 
On Mon, 2004-06-07 at 10:21, Petter Larsen wrote:
> Hello
> 
> I can see several postings on this mailing-list that people have
> problem
> with mounting ext3 partition with mode data=journal.
> 
> See URL's:
> https://www.redhat.com/archives/ext3-users/2004-March/msg00000.html
> https://www.redhat.com/archives/ext3-users/2004-March/msg00050.html
> 
> We are going to use ext3 on a Compact Flash disk in true IDE mode. We
> need this filesystem to be as safe and consistent as possible. We can
> not tolerate any garbage in the files after a crash or sudden power
> failures. We have then decided to use ext3 with mode data=journal.
> 
> Can I rely on this?
> We use kernel 2.6.5 on PowerPC 8260, and may be using newer kernels
> later in the project.
> 
> 
> Best regards
> --
> Petter Larsen
> cand. scient.
> moreCom as
> 913 17 222
> 
> 
> _______________________________________________
> Ext3-users mailing list
> Ext3-users@redhat.com
> https://www.redhat.com/mailman/listinfo/ext3-users
-- 
Petter Larsen
cand. scient.
moreCom as
913 17 222
