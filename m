Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261980AbTDBHKA>; Wed, 2 Apr 2003 02:10:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262000AbTDBHKA>; Wed, 2 Apr 2003 02:10:00 -0500
Received: from smtpde02.sap-ag.de ([155.56.68.170]:20427 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S261980AbTDBHJ7>; Wed, 2 Apr 2003 02:09:59 -0500
From: Christoph Rohland <cr@sap.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: tomlins@cam.org, CaT <cat@zip.com.au>, <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: allow percentile size of tmpfs (2.5.66 / 2.4.20-pre2)
Organisation: Development SAP J2EE Engine
Date: Wed, 02 Apr 2003 09:20:50 +0200
In-Reply-To: <Pine.LNX.4.44.0304011734370.1503-100000@localhost.localdomain> (Hugh
 Dickins's message of "Tue, 1 Apr 2003 17:45:39 +0100 (BST)")
Message-ID: <ovd6k5l60d.fsf@sap.com>
User-Agent: Gnus/5.090016 (Oort Gnus v0.16) XEmacs/21.4 (Native Windows TTY
 Support (Windows), cygwin32)
References: <Pine.LNX.4.44.0304011734370.1503-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SAP: out
X-SAP: out
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hugh,

On Tue, 1 Apr 2003, Hugh Dickins wrote:
> You surprise me, Christoph, I'd expected you to approve of CaT's.

look back into your mail store. I said this pretty early. 

> If tmpfs already defaulted to 50% of ram+swap, then I'd agree
> with you.  But it has all along been in terms of RAM, so I think
> it's better to continue in that way.  (We could add options to
> allow +swap in too, but I'm not terribly interested.)

No, I always thought the 50% RAM was a terrible hack. And IMHO it is
one of the biggest usability gaps of tmpfs. 

> If people really wanted their tmpfs pages to go out to disk, I think
> they'd be choosing a more sophisticated filesystem to manage that:
> swap is a vital overflow area for tmpfs, not its home.

I definitely want them to go there. It is a very sophisticated
mechinsm because by adding swap on _any_ storage I can grow my tmpfs
instances even temporarily.

If you now were able to take advantage of additional swap
automatically administration would be a no brainer. Also distributions
could add much saner defaults for /dev/shm or even use it for /tmp.

Greetings
		Christoph


