Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291463AbSBUMy1>; Thu, 21 Feb 2002 07:54:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291625AbSBUMyS>; Thu, 21 Feb 2002 07:54:18 -0500
Received: from office.mandrakesoft.com ([195.68.114.34]:16378 "EHLO
	office.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S291463AbSBUMyD>; Thu, 21 Feb 2002 07:54:03 -0500
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Adrian Bunk <bunk@fs.tum.de>, Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.18-rc2
In-Reply-To: <Pine.NEB.4.44.0202210924450.3462-100000@mimas.fachschaften.tu-muenchen.de>
	<3C74BDB4.5CD92998@mandrakesoft.com>
X-Url: http://www.lfcia.org/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
In-Reply-To: <3C74BDB4.5CD92998@mandrakesoft.com>
Date: 21 Feb 2002 13:43:29 +0100
Message-ID: <m2zo232efi.fsf@localhost.mandrakesoft.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "jeff" == Jeff Garzik <jgarzik@mandrakesoft.com> writes:

jeff> Adrian Bunk wrote:
>> as discussed in the thread of your 2.4.18-rc1 announcement (see [1] and
>> [2]) 2.4.18 adds CONFIG_FB_TRIDENT but the code doesn't compile.  It's
>> IMHO not a good a idea to add a new option that doesn't compile to a
>> stable kernel. Please apply the patch below that disables this option as a
>> workaround to 2.4.18:

jeff> No -- it's already marked with CONFIG_EXPERIMENTAL.

jeff> Thus if you are compiling this software, you do so at your own risk...

Then remove the:
#error blah blah

from the source file.

Later, Juan.

-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
