Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266116AbUBJSXc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 13:23:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266165AbUBJSUa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 13:20:30 -0500
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:54168 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S266063AbUBJSRc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 13:17:32 -0500
Subject: Re: Security patch for 2.6.2
From: Nicholas Miell <nmiell@attbi.com>
To: Valdis.Kletnieks@vt.edu
Cc: Markus Gaugusch <markus@gaugusch.at>,
       David =?iso-8859-2?Q?Posp=ED=B9il?= <foton2@post.cz>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200402101647.i1AGlvrC006918@turing-police.cc.vt.edu>
References: <200402101709.04825.foton2@post.cz>
	 <Pine.LNX.4.58.0402101716070.7848@dynast.gaugusch.at>
	 <200402101647.i1AGlvrC006918@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1076436931.4999.5.camel@entropy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 10 Feb 2004 10:17:28 -0800
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-02-10 at 08:47, Valdis.Kletnieks@vt.edu wrote:
> On Tue, 10 Feb 2004 17:16:37 +0100, Markus Gaugusch said:
> > On Feb 10, David Pospí¨il <foton2@post.cz> wrote:
> > 
> > > Where can I find security patch for 2.6.2 ?
> > > Problem : look at this site : http://www.securityfocus.com/archive/1/353217
> > > It is remote root exploit :-(
> > No, it is local root exploit. And the patch is attached to that posting.
> 
> Is the *real* problem here that smbfs doesn't understand the moral
> equivalent of 'mount -o nosuid/nodev/noexec/no-etc'?

No, the real problem is that both SAMBA 3 and Linux 2.6.x support the
CIFS Extensions for Unix and the guy who complained to BUGTRAQ doesn't
get this.

(BTW, nosuid/nodev/noexec are handled by the VFS, not the individual fs
drivers.)

