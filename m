Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267399AbTA3Ek0>; Wed, 29 Jan 2003 23:40:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267403AbTA3Ek0>; Wed, 29 Jan 2003 23:40:26 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:16512
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id <S267399AbTA3Ek0>; Wed, 29 Jan 2003 23:40:26 -0500
Message-ID: <3E38AE24.6090703@redhat.com>
Date: Wed, 29 Jan 2003 20:46:28 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030128
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
CC: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Change sendfile header
References: <Pine.LNX.3.96.1030129215509.7114C-100000@gatekeeper.tmr.com>
In-Reply-To: <Pine.LNX.3.96.1030129215509.7114C-100000@gatekeeper.tmr.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote:
> I suggest that the header holding the prototype for sendfile should not be
> in unistd.h because:

Why do you complain?  And why here?

The sendfile prototype is in <sys/sendfile.h> and not in <unistd.h>.
So, what do you want?  sys/ is the directory for system-specific headers
so this is exactly the place to put this header.  And as for the rest:
apparently people already had ideas like this just much earlier and you
didn't even bother to check.

-- 
--------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------

