Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132508AbRDNAPx>; Fri, 13 Apr 2001 20:15:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132531AbRDNAPo>; Fri, 13 Apr 2001 20:15:44 -0400
Received: from runyon.cygnus.com ([205.180.230.5]:23289 "EHLO cygnus.com")
	by vger.kernel.org with ESMTP id <S132508AbRDNAPc>;
	Fri, 13 Apr 2001 20:15:32 -0400
To: Jerry Hong <jhong001@yahoo.com>
Cc: gcc@gcc.gnu.org, linux-kernel@vger.kernel.org
Subject: Re: thread problem with libc for Linux
In-Reply-To: <20010413204557.21595.qmail@web4306.mail.yahoo.com>
From: Alexandre Oliva <aoliva@redhat.com>
Organization: GCC Team, Red Hat
Date: 13 Apr 2001 21:15:13 -0300
In-Reply-To: <20010413204557.21595.qmail@web4306.mail.yahoo.com>
Message-ID: <orzodk49ri.fsf@guarana.lsd.ic.unicamp.br>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 13, 2001, Jerry Hong <jhong001@yahoo.com> wrote:

> Program received signal SIGSEGV, Segmentation fault.
> 0x401ca0d6 in chunk_free (ar_ptr=0x4025ed60,
> p=0x80a1ba8) at malloc.c:3097

This is usually a symptom of memory corruption in your own program.
It's damaging libc's internal data structures.  I.e., this probably
has nothing to do with GCC or the kernel.

-- 
Alexandre Oliva   Enjoy Guarana', see http://www.ic.unicamp.br/~oliva/
Red Hat GCC Developer                  aoliva@{cygnus.com, redhat.com}
CS PhD student at IC-Unicamp        oliva@{lsd.ic.unicamp.br, gnu.org}
Free Software Evangelist    *Please* write to mailing lists, not to me
