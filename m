Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262182AbTJ3D6E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 22:58:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262193AbTJ3D6E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 22:58:04 -0500
Received: from lvs00-fl-n02.valueweb.net ([216.219.253.98]:60039 "EHLO
	ams002.ftl.affinity.com") by vger.kernel.org with ESMTP
	id S262182AbTJ3D6B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 22:58:01 -0500
Message-ID: <3FA08C42.6050107@coyotegulch.com>
Date: Wed, 29 Oct 2003 22:57:54 -0500
From: Scott Robert Ladd <coyote@coyotegulch.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031024 Debian/1.5-2
X-Accept-Language: en
MIME-Version: 1.0
To: "Theodore Ts'o" <tytso@mit.edu>
CC: Erik Andersen <andersen@codepoet.org>, Hans Reiser <reiser@namesys.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Things that Longhorn seems to be doing right
References: <3F9F7F66.9060008@namesys.com> <20031029224230.GA32463@codepoet.org> <20031030015212.GD8689@thunk.org>
In-Reply-To: <20031030015212.GD8689@thunk.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Ts'o wrote:
> Keep in mind that just because Windows does thing a certain way 
> doesn't mean we have to provide the same functionality in exactly the
> same way.

Very true. Linux is best defined by those who proactively implement
powerful ideas.

That doesn't mean, however, that the folks in Redmond can't come up with
an interesting and useful idea that we might just want to consider.

> Also keep in mind that Microsoft very deliberately blurs what they do
> in their "kernel" versus what they provide via system libraries
> (i.e., API's provided via their DLL's, or shared libraries).

Any database-style file system should be implemented in a modular
fashion, just like current Linux file systems.

Microsoft's penchant for integrating everything is their greatest
weakness (in terms of security) as well as their greatest strength (in
terms of customer lock-in). Since we don't care about locking anyone
into anything, we don't have those nasty marketing droids forcing us to
make poor technical choices.

> There are multiple ways of skinning this particular cat, and we don't
> need to blindly follow Microsoft's design mistakes.

Agreed -- but we might want pay attention, in case skinning cats has
some actual value.

(Disclaimer: No felines were harmed in the production of this e-mail.)

> Fortunately, I have enough faith in Linus Torvalds' taste that I'm
> not particularly worried what would happen if someone were to send
> him a patch that attempted to cram MySQL or Postgres into the guts of
> the Linux kernel....  although I would like to watch when someone
> proposes such a thing!

MySQL wouldn't need to be shoved into the kernel; a small, fast database 
engine (one of my professional specialities, BTW) could provide metadata 
services in a file system module. SQL is a bloated pig; an effective 
file system needs to be both useful and efficient, leading me to think 
that we should consider a more succinct query mechanism for any 
metadata-based file system.

-- 
Scott Robert Ladd
Coyote Gulch Productions (http://www.coyotegulch.com)
Software Invention for High-Performance Computing

