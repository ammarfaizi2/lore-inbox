Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136475AbREDSHD>; Fri, 4 May 2001 14:07:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136476AbREDSGx>; Fri, 4 May 2001 14:06:53 -0400
Received: from chromium11.wia.com ([207.66.214.139]:59403 "EHLO
	neptune.kirkland.local") by vger.kernel.org with ESMTP
	id <S136475AbREDSGe>; Fri, 4 May 2001 14:06:34 -0400
Message-ID: <3AF2F09C.C5731842@chromium.com>
Date: Fri, 04 May 2001 11:10:36 -0700
From: Fabio Riccardi <fabio@chromium.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: mingo@elte.hu
CC: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Christopher Smith <x@xman.org>, Andrew Morton <andrewm@uow.edu.au>,
        "Timothy D. Witham" <wookie@osdlab.org>, David_J_Morse@Dell.com
Subject: Re: X15 alpha release: as fast as TUX but in user space
In-Reply-To: <Pine.LNX.4.33.0105041028430.2178-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ok, I'm totally ignorant here, what is a pipelined request?

btw: please be kind with my mistakes, X15 _is_ alpha code anyway... :)

 - Fabio

Ingo Molnar wrote:

> yet another anomaly i noticed. X15 does not appear to handle pipelined
> HTTP/1.1 requests properly, it ignores the second request if two requests
> arrive in the same packet.
>
> SPECweb99 does not send pipelined requests, but a number of RL web clients
> do. (Mozilla, apt-get, etc.)
>
>         Ingo

