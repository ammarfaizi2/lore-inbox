Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261238AbUDEJS7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 05:18:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261678AbUDEJS6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 05:18:58 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:28331 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S261238AbUDEJS5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 05:18:57 -0400
Date: Mon, 5 Apr 2004 11:18:48 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Jamie Lokier <jamie@shareable.org>, Pavel Machek <pavel@ucw.cz>, mj@ucw.cz,
       jack@ucw.cz, "Patrick J. LoPresti" <patl@users.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cowlinks v2
Message-ID: <20040405091848.GH28924@wohnheim.fh-wedel.de>
References: <20040402180128.GA363@elf.ucw.cz> <20040402181707.GA28112@wohnheim.fh-wedel.de> <20040402182357.GB410@elf.ucw.cz> <20040402200921.GC653@mail.shareable.org> <20040402213933.GB246@elf.ucw.cz> <20040403010425.GJ653@mail.shareable.org> <m1n05soqh2.fsf@ebiederm.dsl.xmission.com> <20040403194344.GA5477@mail.shareable.org> <20040405083549.GD28924@wohnheim.fh-wedel.de> <m1hdvyn5uy.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <m1hdvyn5uy.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 April 2004 03:15:01 -0600, Eric W. Biederman wrote:
> 
> I know a writable mmap needs to trigger a copy in that case.
> And then are fun cases with MAP_FIXED which may mean invalidation
> is not allowed.

Sounds fishy, so it will trigger cow.  Done. :)

> As scheme that does not isolate the invalidate to the new copy worries me.

If you can come up with a better way, please do.  Right now I cannot
think of anything better, but Pavel already showed how little that
means.

Jörn

-- 
The wise man seeks everything in himself; the ignorant man tries to get
everything from somebody else.
-- unknown
