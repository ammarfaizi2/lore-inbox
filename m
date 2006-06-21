Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932146AbWFUNhz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932146AbWFUNhz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 09:37:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932151AbWFUNhz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 09:37:55 -0400
Received: from mx1.redhat.com ([66.187.233.31]:4807 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932146AbWFUNhx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 09:37:53 -0400
To: Ian Kent <raven@themaw.net>
Cc: akpm@osdl.org, autofs@linux.kernel.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [autofs] [PATCH] autofs4 needs to force fail return revalidate
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
References: <200606210618.k5L6IFDr008176@raven.themaw.net>
From: Jeff Moyer <jmoyer@redhat.com>
Date: Wed, 21 Jun 2006 09:37:20 -0400
In-Reply-To: <200606210618.k5L6IFDr008176@raven.themaw.net> (Ian Kent's
 message of "Wed, 21 Jun 2006 14:18:15 +0800")
Message-ID: <x49irmuhbov.fsf@segfault.boston.redhat.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

==> Regarding [autofs] [PATCH] autofs4 needs to force fail return revalidate; Ian Kent <raven@themaw.net> adds:

raven> Hi Andrew,

raven> I didn't get any adverse (or other feedback) for this patch after
raven> posting an RFC to LKML so here it is.

raven> For a long time now I have had a problem with not being able to
raven> return a lookup failure on an existsing directory. In autofs this
raven> corresponds to a mount failure on a autofs managed mount entry that
raven> is browsable (and so the mount point directory exists).

raven> While this problem has been present for a long time I've avoided
raven> resolving it because it was not very visible. But now that autofs v5
raven> has "mount and expire on demand" of nested multiple mounts, such as
raven> is found when mounting an export list from a server, solving the
raven> problem cannot be avoided any longer.

raven> I've tried very hard to find a way to do this entirely within the
raven> autofs4 module but have not been able to find a satisfactory way to
raven> achieve it.

raven> So, I need to propose a change to the VFS.

raven> Signed-off-by: Ian Kent <raven@themaw.net>

Acked-by: Jeff Moyer <jmoyer@redhat.com>

-Jeff
