Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135395AbRDWPhn>; Mon, 23 Apr 2001 11:37:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135397AbRDWPhh>; Mon, 23 Apr 2001 11:37:37 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:63927 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S135353AbRDWPeq>;
	Mon, 23 Apr 2001 11:34:46 -0400
Message-ID: <3AE44B9A.DA8A5CCA@mandrakesoft.com>
Date: Mon, 23 Apr 2001 11:34:50 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: light weight user level semaphores
In-Reply-To: <E14qHRp-0007Yc-00@the-village.bc.nu> <Pine.LNX.4.31.0104190944090.4074-100000@penguin.transmeta.com> <E14qXEU-0005xo-00@g212.hadiko.de> <9bqgvi$63q$1@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> Trust me. You're arguing for clearly broken behaviour. malloc() and
> friends MUST NOT open file descriptors. It _will_ break programs that
> rely on traditional and documented features.

Indeed; STDIN_FILENO and friends are constants...

-- 
Jeff Garzik      | The difference between America and England is that
Building 1024    | the English think 100 miles is a long distance and
MandrakeSoft     | the Americans think 100 years is a long time.
                 |      (random fortune)
