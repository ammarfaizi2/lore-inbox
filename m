Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270457AbRHHLjJ>; Wed, 8 Aug 2001 07:39:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270462AbRHHLi7>; Wed, 8 Aug 2001 07:38:59 -0400
Received: from hera.cwi.nl ([192.16.191.8]:34285 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S270455AbRHHLiy>;
	Wed, 8 Aug 2001 07:38:54 -0400
From: Andries.Brouwer@cwi.nl
Date: Wed, 8 Aug 2001 11:38:31 GMT
Message-Id: <200108081138.LAA33721@vlet.cwi.nl>
To: Andries.Brouwer@cwi.nl, viro@math.psu.edu
Subject: Re: [RFC][PATCH] parser for mount options
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From: Alexander Viro <viro@math.psu.edu>

    On Tue, 7 Aug 2001 Andries.Brouwer@cwi.nl wrote:

    >     while (more_tokens) {
    >         t = type_of_next_token();
    >         switch (t) {
    >         case ...
    >         }
    >     }
    > 
    > where the type_of_next_token() does the parsing, and the switch
    > does the assigning. Much more code. Much uglier - but tastes differ.

    I would agree, if in all cases it was about assigning a single value.
    It isn't.

It was for 1.3.61. What cases have we now that are more complicated?

