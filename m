Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272672AbTHKOjJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 10:39:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272680AbTHKOjJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 10:39:09 -0400
Received: from mx1.redhat.com ([66.187.233.31]:34062 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S272672AbTHKOjC (ORCPT
	<rfc822;linux-kernel@vger.redhat.com>);
	Mon, 11 Aug 2003 10:39:02 -0400
Subject: Re: volatile variable
From: David Woodhouse <dwmw2@infradead.org>
To: root@chaos.analogic.com
Cc: Dinesh Gandhewar <dinesh_gandhewar@rediffmail.com>,
       mlist-linux-kernel@nntp-server.caltech.edu
In-Reply-To: <Pine.LNX.4.53.0308110944350.17240@chaos>
References: <20030801105706.30523.qmail@webmail28.rediffmail.com>
	 <Pine.LNX.4.53.0308010723060.3077@chaos>
	 <1060608783.19194.13.camel@passion.cambridge.redhat.com>
	 <Pine.LNX.4.53.0308110944350.17240@chaos>
Content-Type: text/plain
Message-Id: <1060612734.32631.24.camel@passion.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (dwmw2) 
Date: Mon, 11 Aug 2003 15:38:54 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was about to compose a reply contradicting you, but I can't be
bothered. Dinesh -- the answer remains: do not use sleep_on() (you could
perhaps use wait_event() instead though), and do not gratuitously make
your variable volatile.

Richard, you're amusing to read, and have hence escaped my killfiles
because I sometimes find it amusingly tricky to find your mistake --
sometimes I have to read your messages two or three times before I spot
your errors, but they're always there somewhere. It must take a large
amount of effort and skill to present arguments which are so close to
the truth as to appear authoritative, yet introduce errors which are
often so subtle. I cannot imagine that you achieve this so consistently
by accident alone, and respect greatly your ability to do this.

I appreciate the amusement you provide for those who are familiar with
your behaviour -- and interjected on this occasion only because you
seemed to be misleading a newbie who wasn't likely to be aware of your
history, without even much subtlety to your errors.

It may be vaguely amusing for those who are watching from the sidelines
-- but in this instance you seem to be being a little unfair :)

-- 
dwmw2

