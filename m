Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268802AbUILTRC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268802AbUILTRC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 15:17:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268803AbUILTRB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 15:17:01 -0400
Received: from mail.joq.us ([67.65.12.105]:57736 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S268802AbUILTQ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 15:16:59 -0400
To: James Morris <jmorris@redhat.com>
Cc: Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, <torbenh@gmx.de>
Subject: Re: [PATCH] Realtime LSM
References: <Xine.LNX.4.44.0409120956150.16684-100000@thoron.boston.redhat.com>
From: "Jack O'Quin" <joq@io.com>
Date: 12 Sep 2004 14:16:50 -0500
In-Reply-To: <Xine.LNX.4.44.0409120956150.16684-100000@thoron.boston.redhat.com>
Message-ID: <871xh7thzx.fsf@sulphur.joq.us>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Morris <jmorris@redhat.com> writes:

> I wonder if it might be better to specify configuration via 
> /proc/<pid>/attr rather than module parameters.

We discussed configuration via /proc, and it seems worthwhile.  

Maybe I don't understand the details of what you propose.  I don't
find the /proc/<pid> approach attractive because it seems difficult to
administer.  But, setting something global like /proc/realtime/group
or /proc/realtime/any would make a good enhancement to the current
interface.

I have not implemented that yet because (1) the current approach has
proven adequate for the Linux audio user community, and (2) I haven't
wanted to spend time mastering the internal kernel interfaces for
accessing /proc from an LSM.  I know it's not difficult, but I had
other things I'd rather do.  :-)

Thanks for the suggestion,
-- 
  joq
