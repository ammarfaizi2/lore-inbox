Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265849AbRFYCvH>; Sun, 24 Jun 2001 22:51:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265850AbRFYCu5>; Sun, 24 Jun 2001 22:50:57 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:21517 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S265849AbRFYCur>; Sun, 24 Jun 2001 22:50:47 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Russell Leighton <russell.leighton@247media.com>,
        Jason McMullan <jmcmullan@linuxcare.com>
Subject: Re: What are the VM motivations??
Date: Mon, 25 Jun 2001 04:53:46 +0200
X-Mailer: KMail [version 1.2]
Cc: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
In-Reply-To: <20010621190103.A888@jmcmullan.resilience.com> <20010624140114.A10745@jmcmullan.resilience.com> <3B3697FB.3B7F098@247media.com>
In-Reply-To: <3B3697FB.3B7F098@247media.com>
MIME-Version: 1.0
Message-Id: <01062504534600.16346@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 25 June 2001 03:46, Russell Leighton wrote:
> I read this thread as asking the question:
>
>     If VM management is viewed as an optimization problem,
>     then what exactly is the function that you are optimizing and what are
> the constraints?
>
> If you could express that well with a even a very loose model, then
> the code could be reviewed to see if it was really doing what was intended
> and assumptions could be tested.

May I suggested an algorithm?

  - Write down what you think the optimization constraints are.
    (be specific, for example, enumerate all the flavors of page types -
    process code, process data, page cache file data, page cache swap
    cache, anonymous, shmem, etc.)

  - Write down what you think the current algorithms are.
    (again, be specific, use file names, function names, pseudocode and 
    snippets of existing code.)

  - Send it to Rik.  He'll tell you if it's right.

  - Because life is short and should not be boring, cc it to Andrea as well
    ;-)

This way you save everybody's time and ensure you understand what's really 
going on.  Not to mention coming up with a document worth its weight in 
dilithium crystals.

--
Daniel
