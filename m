Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132865AbRDPGoG>; Mon, 16 Apr 2001 02:44:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132866AbRDPGn5>; Mon, 16 Apr 2001 02:43:57 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:46047 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S132865AbRDPGnl>;
	Mon, 16 Apr 2001 02:43:41 -0400
Message-ID: <3ADA949C.D10D8536@mandrakesoft.com>
Date: Mon, 16 Apr 2001 02:43:40 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-19mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Patrick Shirkey <pshirkey@boosthardware.com>, linux-kernel@vger.kernel.org
Subject: Re: Files not linking/replacing.
In-Reply-To: <3ADA524A.7038A81C@boosthardware.com> <m1eluttkx2.fsf@frodo.biederman.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric W. Biederman" wrote:
> Normally /usr/src/linux on a redhat system contains a kernel with a
> known good set of kernel headers.  /usr/include/linux and
> /usr/include/asm are symlinks that point into the known good kernel
> headers.  It looks like you removed your known good 2.2.14 known good
> kernel headers, or the symlinks to them.

Modern glibc systems have their own copies of headers for
/usr/include/{asm,linux}, and those locations should not be pointing to
kernel space...

-- 
Jeff Garzik       | "Give a man a fish, and he eats for a day. Teach a
Building 1024     |  man to fish, and a US Navy submarine will make sure
MandrakeSoft      |  he's never hungry again." -- Chris Neufeld
