Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263605AbTLXNLR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Dec 2003 08:11:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263622AbTLXNLR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Dec 2003 08:11:17 -0500
Received: from dsl-hkigw3l52.dial.inet.fi ([80.222.43.82]:36026 "EHLO
	uworld.dyndns.org") by vger.kernel.org with ESMTP id S263605AbTLXNLJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Dec 2003 08:11:09 -0500
Subject: Re: SCO's infringing files list
From: Jussi Laako <jussi@sonarnerd.net>
To: Norman Diamond <ndiamond@wta.att.ne.jp>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <123a01c3ca18$346117b0$43ee4ca5@DIAMONDLX60>
References: <123a01c3ca18$346117b0$43ee4ca5@DIAMONDLX60>
Content-Type: text/plain
Organization: 
Message-Id: <1072271492.7160.27.camel@vaarlahti.uworld>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 24 Dec 2003 15:11:32 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-12-24 at 14:19, Norman Diamond wrote:

> > > /* This is a list of all known signal numbers.  */
> > >
> > > CONST char *CONST _sys_errlist[] = {
> >
> > I wonder if there are any UNIX sources which have a similar typo.
> 
> That kind of error (typo, thinko, etc.) was more common than you think.  The
> related file /usr/include/errno.h was source code readable by everyone.  If
> anyone has a copy of errno.h from BSD days (when BSD wasn't completely free
> yet), it would be worth checking.  If this comment was copied from BSD then
> the next question is whether this comment originated at BSD or was copied
> from ATT.

At least the 4.2 (file dated 7/29/83) or the 4.3reno (file dated
6/28/90) doesn't contain such comment. There's no copyright statement in
4.2, but there is in 4.3reno.


4.2 (& 4.3):
--- 8< ---
/*
 * Error codes
 */
--- 8< ---
#define ENOTTY          25              /* Not a typewriter */
--- 8< ---


4.3reno:
--- 8< ---
#define ENOTTY          25              /* Inappropriate ioctl for
device */
--- 8< ---


-- 
Jussi Laako <jussi@sonarnerd.net>

