Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262682AbSJGXqJ>; Mon, 7 Oct 2002 19:46:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262723AbSJGXqJ>; Mon, 7 Oct 2002 19:46:09 -0400
Received: from mons.uio.no ([129.240.130.14]:61662 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S262682AbSJGXqI>;
	Mon, 7 Oct 2002 19:46:08 -0400
To: Juan Gomez <juang@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernelNFS(lockd) problem and patch suggestion
References: <OF2F07E0DC.299628DE-ON87256C4B.00790F36@us.ibm.com>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 08 Oct 2002 01:51:40 +0200
In-Reply-To: <OF2F07E0DC.299628DE-ON87256C4B.00790F36@us.ibm.com>
Message-ID: <shsk7ktst83.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Juan Gomez <juang@us.ibm.com> writes:

     > After taking a look at the code I realized that the lockd
     > thread sets grace period and then goes to sleep for a long time
     > waiting for messages and the first message always gets
     > processed before checking if the grace period has completed

Please could you rediff using the '-u' option and drop the MIME
attachment thingy (See Documentation/SubmittingPatches).

Patch otherwise looks quite correct, so once the patch format is OK
then, by all means send it off to Marcelo and (if you could bang up
the same patch for 2.5.x) to Linus too.

Cheers,
  Trond
