Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261662AbUCBOwy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 09:52:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261664AbUCBOwy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 09:52:54 -0500
Received: from ore.jhcloos.com ([64.240.156.239]:55049 "EHLO ore.jhcloos.com")
	by vger.kernel.org with ESMTP id S261662AbUCBOwx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 09:52:53 -0500
To: hpa@zytor.com (H. Peter Anvin)
Cc: linux-kernel@vger.kernel.org
Subject: Re: something funny about tty's on 2.6.4-rc1-mm1
From: "James H. Cloos Jr." <cloos@jhcloos.com>
In-Reply-To: <c2175f$6hn$1@terminus.zytor.com> (H. Peter Anvin's message of
 "Tue, 2 Mar 2004 05:47:27 +0000 (UTC)")
References: <20040301184512.GA21285@hobbes.itsari.int>
	<c2175f$6hn$1@terminus.zytor.com>
Date: Tue, 02 Mar 2004 09:52:37 -0500
Message-ID: <m3u1175miy.fsf@lugabout.jhcloos.org>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Peter" == H Peter Anvin <hpa@zytor.com> writes:

Peter> As RBJ said, ptys are now recycled in pid-like fashion, which
Peter> means numbers won't be reused until wraparound happens.

Ouch.  I've been using the tty name in $HISTFILE for some time now
(at least on laptops and workstations); I do not see any reasonable
alternative to prevent overwriting while still saving history.

Will patching in the old behavior wrt re-use, while not disrupting
the other improvements, be a lot of work?  I've looked thru the src, 
but haven't yet spotted the point where the new pis number is chosen.

-JimC



