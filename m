Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281416AbRLIBx4>; Sat, 8 Dec 2001 20:53:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281420AbRLIBxq>; Sat, 8 Dec 2001 20:53:46 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:45361 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S281416AbRLIBxi>; Sat, 8 Dec 2001 20:53:38 -0500
To: Tom Vier <tmv5@home.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [OT] fputc vs putc Re: horrible disk thorughput on itanium
In-Reply-To: <p73n10v6spi.fsf@amdsim2.suse.de>
	<20011207.124202.48805183.davem@redhat.com>
	<3C112DE4.60206@antefacto.com>
	<20011207.130316.39156883.davem@redhat.com> <20011208201907.A937@zero>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 08 Dec 2001 18:33:38 -0700
In-Reply-To: <20011208201907.A937@zero>
Message-ID: <m1d71pw51p.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Vier <tmv5@home.com> writes:

> On Fri, Dec 07, 2001 at 01:03:16PM -0800, David S. Miller wrote:
> > They do it also for putc() if you haven't defined the appropriate
> > defines.
> 
> what exactly is the difference between putc() and fputc()? the man page is
> very vague.

fputc is a function putc is a macro because the overhead of a function call
in writing a character has always been a problem...

Eric
