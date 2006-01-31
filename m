Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750723AbWAaJQV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750723AbWAaJQV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 04:16:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750725AbWAaJQV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 04:16:21 -0500
Received: from iona.labri.fr ([147.210.8.143]:14752 "EHLO iona.labri.fr")
	by vger.kernel.org with ESMTP id S1750723AbWAaJQT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 04:16:19 -0500
Message-ID: <43DF2A97.1030508@labri.fr>
Date: Tue, 31 Jan 2006 10:15:03 +0100
From: Emmanuel Fleury <emmanuel.fleury@labri.fr>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: [ASLR] Better control on Randomization
References: <43DE710F.9020408@labri.fr>
In-Reply-To: <43DE710F.9020408@labri.fr>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Just to say what use I intend to do with this. :)

I'm giving a lecture on software security and I'm trying to have a
kernel in which you can add/remove security features in order to make
the students learn and practice some attacks (this kernel should run
into a UML process).

Ideally, I would like to be able to activate/deactivate (independently):
- Stack randomization
- Heap randomization
- Library randomization
- Non-executable stack

(for the last one, as the kernel will be minimum (No X, no JVM), it
might be easier to NOT consider the trampoline functions).

Well, for now I'm just looking of the _feasibility_ of this idea
(and how hard would it be to make it run in UML).

Any comments or ideas are more than welcome. :)

Regards
-- 
Emmanuel Fleury

That's the whole problem with science. You've got a bunch of
empiricists trying to describe things of unimaginable wonder.
  -- Calvin & Hobbes (Bill Waterson)
