Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264883AbTACDPE>; Thu, 2 Jan 2003 22:15:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267225AbTACDPE>; Thu, 2 Jan 2003 22:15:04 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:60621
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id <S264883AbTACDPD>; Thu, 2 Jan 2003 22:15:03 -0500
Message-ID: <3E150221.3030304@redhat.com>
Date: Thu, 02 Jan 2003 19:23:13 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20021224
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: "J.A. Magallon" <jamagallon@able.es>, libc-alpha@sources.redhat.com,
       Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: __NR_exit_group for 2.4-O(1)
References: <20030103001522.GA1539@werewolf.able.es> <20030103003244.A10586@infradead.org> <20030103003617.GC1539@werewolf.able.es> <20030103004557.A10881@infradead.org> <20030103005033.GA3103@werewolf.able.es> <20030103005624.A11159@infradead.org>
In-Reply-To: <20030103005624.A11159@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:

> Hmm.  It looks like glibc should test for something else than :)

The code is correct as it is.  If the exit_group syscall does not exist
the normal exit is used.  There is by definition exactly one call to any
of these syscalls so who cares?

If there is any problem it is your strace which is far too old.

-- 
--------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------

