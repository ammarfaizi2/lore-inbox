Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129596AbRBFGe7>; Tue, 6 Feb 2001 01:34:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131385AbRBFGet>; Tue, 6 Feb 2001 01:34:49 -0500
Received: from deliverator.sgi.com ([204.94.214.10]:16679 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S129596AbRBFGek>; Tue, 6 Feb 2001 01:34:40 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Kevin Hilman <khilman@equator.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: make problem: -Dfoo='"bar"' and FILES_FLAGS_CHANGED in .flags 
In-Reply-To: Your message of "05 Feb 2001 13:47:10 -0800."
             <r24ry82469.fsf@bobdog.equator.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 06 Feb 2001 17:34:28 +1100
Message-ID: <1290.981441268@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 05 Feb 2001 13:47:10 -0800, 
Kevin Hilman <khilman@equator.com> wrote:
>When using -Dfoo='"bar"' in CFLAGS, it ends up as -Dfoo=bar in the
>.flags file.  This difference causes the FILES_FLAGS_CHANGED to get
>set for any files that have that in their CFLAGS, and therefore they
>are always remade.

Try using -Dfoo=\"bar\" instead.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
