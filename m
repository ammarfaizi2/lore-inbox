Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129381AbRC2W4h>; Thu, 29 Mar 2001 17:56:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129436AbRC2W41>; Thu, 29 Mar 2001 17:56:27 -0500
Received: from smtp.mountain.net ([198.77.1.35]:21515 "EHLO riker.mountain.net")
	by vger.kernel.org with ESMTP id <S129381AbRC2W4T>;
	Thu, 29 Mar 2001 17:56:19 -0500
Message-ID: <3AC3BD64.7702CD7B@mountain.net>
Date: Thu, 29 Mar 2001 17:55:32 -0500
From: Tom Leete <tleete@mountain.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.2 i486)
X-Accept-Language: en-US,en-GB,en,fr,es,it,de,ru
MIME-Version: 1.0
To: Ulrich Drepper <drepper@cygnus.com>
CC: dank@trellisinc.com, linux-kernel@vger.kernel.org,
   Eli Carter <eli.carter@inet.com>
Subject: Re: [PATCH] pcnet32 compilation fix for 2.4.3pre6
In-Reply-To: <20010329210925.3161C6E099@fancypants.trellisinc.com> <m3hf0cs1xu.fsf@otr.mynet.cygnus.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper wrote:
> 
> dank@trellisinc.com writes:
> 
> > with the new ansi standard, this use of __inline__ is no longer
> > necessary,
> 
> This is not correct.  Since the semantics of inline in C99 and gcc
> differ all code which depends on the gcc semantics should continue to
> use __inline__ since this keyword will hopefully forever signal the
> gcc semantics.

Unfortunately, it seems that gcc will define __inline__ as a synonym for
inline, whatever inline is currently in use. I asked this on the gcc list a
while ago. The archive there should have the replies.

Regards,
Tom

-- 
The Daemons lurk and are dumb. -- Emerson
