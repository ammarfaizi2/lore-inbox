Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268916AbRIJJcT>; Mon, 10 Sep 2001 05:32:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269779AbRIJJcJ>; Mon, 10 Sep 2001 05:32:09 -0400
Received: from mailhost.cendio.se ([193.180.23.130]:46581 "EHLO mail.cendio.se")
	by vger.kernel.org with ESMTP id <S268916AbRIJJcA>;
	Mon, 10 Sep 2001 05:32:00 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: nfs is stupid ("getfh failed")
In-Reply-To: <002b01c136e1$3bb36a80$81d4870a@cartman>
	<15260.25562.278698.458611@notabene.cse.unsw.edu.au>
From: Marcus Sundberg <marcus@cendio.se>
Date: 10 Sep 2001 11:32:20 +0200
In-Reply-To: <15260.25562.278698.458611@notabene.cse.unsw.edu.au>
Message-ID: <ve66arqtln.fsf@inigo.sthlm.cendio.se>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

neilb@cse.unsw.edu.au (Neil Brown) writes:

> SUNs "cachefs" concept can be used to improve read performance by
> caching a lot more of server-data on the client.  That could be
> implemented for Linux, but I don't know of anyone with serious plans.

cachefs sucks. It doesn't seem to cache stat(2) information.
Doing ls -F in a ~100-entries directory takes several seconds over
a link with 50ms round-trip time.

//Marcus
-- 
---------------------------------+---------------------------------
         Marcus Sundberg         |      Phone: +46 707 452062
   Embedded Systems Consultant   |     Email: marcus@cendio.se
        Cendio Systems AB        |      http://www.cendio.com
