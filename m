Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285059AbRLQIuc>; Mon, 17 Dec 2001 03:50:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285058AbRLQIuX>; Mon, 17 Dec 2001 03:50:23 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:17157 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S285059AbRLQIuK>; Mon, 17 Dec 2001 03:50:10 -0500
Message-ID: <3C1DB1C4.316EC802@idb.hist.no>
Date: Mon, 17 Dec 2001 09:50:12 +0100
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.1-pre10 i686)
X-Accept-Language: no, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kill(-1,sig)
In-Reply-To: <Pine.LNX.4.33.0112141237470.3063-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> Count one for the complaints, but I want more to overrule a published
> standard.
> 
> (Of course, a language lawyer will call "self" a "system process",
> although I cannot for the life of me really see what kind of excuse we
> would come up with to do se ;)

Root doing a kill -1 -9 is definitely doing system administration,
hence it is a "system process." I never do this as a user,
but think about what happens at shutdown time.  At least a
root process ought to survive this.

Helge Hafting
