Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129159AbRBOPiv>; Thu, 15 Feb 2001 10:38:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129233AbRBOPim>; Thu, 15 Feb 2001 10:38:42 -0500
Received: from tomts7.bellnexxia.net ([209.226.175.40]:51897 "EHLO
	tomts7-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S129159AbRBOPib>; Thu, 15 Feb 2001 10:38:31 -0500
Message-ID: <3A8BF697.D594237F@sympatico.ca>
Date: Thu, 15 Feb 2001 10:32:39 -0500
From: Jeremy Jackson <jeremy.jackson@sympatico.ca>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Is this the ultimate stack-smash fix?
In-Reply-To: <3A899FEB.D54ABBC7@sympatico.ca> <m1lmr98c5t.fsf@frodo.biederman.org> <3A8ADA30.2936D3B1@sympatico.ca> <m1hf1w8qea.fsf@frodo.biederman.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric W. Biederman" wrote:

> Jeremy Jackson <jeremy.jackson@sympatico.ca> writes:
>
> > "Eric W. Biederman" wrote

> No.  I'm not talking about stack-guard patches.  I'm talking about bounds checking.

Sorry, I was quite incoherent.  Many others have pointed out that there exist
patches for non-executatble stack, and the problems with it. That's what I meant to
comment on.  But I'm glad to find out about bounds checking as an option.

> But the gcc bounds checking work is the ultimate buffer overflow fix.
> You can recompile all of your trusted applications, and libraries with
> it and be safe from one source of bugs.

That's why I was wondering of limiting privileged addresses security at a more
fundamental level... as you say above,
this fixes *ONE* source of bugs(security threats)... but itn't it inevitable that
there will be others?  But if services are each put
in a separate box, that doesn't have a door leading to the inner sanctum, things would
be more secure in spite of "bugs".

Well I thank everyone for their responses in this thread, I think It's been beaten
into the ground (my original idea),
and I'm left with some food for thought.


