Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311724AbSCNSn5>; Thu, 14 Mar 2002 13:43:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311723AbSCNSns>; Thu, 14 Mar 2002 13:43:48 -0500
Received: from 213-98-126-44.uc.nombres.ttd.es ([213.98.126.44]:14977 "HELO
	mitica.trasno.org") by vger.kernel.org with SMTP id <S311726AbSCNSnd>;
	Thu, 14 Mar 2002 13:43:33 -0500
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: pcmcia oops problem?
In-Reply-To: <3C90BA11.40106@mandrakesoft.com> <m2henjruos.fsf@trasno.mitica>
	<200203141801.g2EI1sK00638@vindaloo.ras.ucalgary.ca>
X-Url: http://www.lfcia.org/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
In-Reply-To: <200203141801.g2EI1sK00638@vindaloo.ras.ucalgary.ca>
Date: 14 Mar 2002 19:40:54 +0100
Message-ID: <m23cz3ro09.fsf@trasno.mitica>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "richard" == Richard Gooch <rgooch@ras.ucalgary.ca> writes:

richard> Juan Quintela writes:
>> >>>>> "jeff" == Jeff Garzik <jgarzik@mandrakesoft.com> writes:
>> 
jeff> Can you describe the pcmcia oops problem in detail?
jeff> What output do you get from a serial console?
>> 
>> Ok, trying to get better message now.

richard> Can you:

richard> - capture the Oops and decode with ksymoops

stack overflow, when we got the Oops, we have already overwrote half
the memory, i.e. the stack trace makes no sense at all :(

richard> - make sure you always Cc: me on devfs-related problems (I nearly
richard> missed this one).

Not sure what is this one, and I am beggining to think that the
problem is some subtle thing in andrea_vm.

Later, Juan.

-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
