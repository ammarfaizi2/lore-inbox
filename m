Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289317AbSBEAgh>; Mon, 4 Feb 2002 19:36:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289326AbSBEAg1>; Mon, 4 Feb 2002 19:36:27 -0500
Received: from tomts22.bellnexxia.net ([209.226.175.184]:5855 "EHLO
	tomts22-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S289317AbSBEAgV>; Mon, 4 Feb 2002 19:36:21 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Roger Larsson <roger.larsson@norran.net> (by way of Roger Larsson
	<roger.larsson@norran.net>),
        list linux-kernel <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: New VM Testcase (2.4.18pre7 SWAPS) (2.4.17-rmap12b OK)
Date: Mon, 4 Feb 2002 19:36:13 -0500
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <200202042227.g14MRFN12329@maile.telia.com>
In-Reply-To: <200202042227.g14MRFN12329@maile.telia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20020205003614.1036BF6E7@oscar.casa.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On February 4, 2002 05:24 pm, Roger Larsson wrote:
> When examining Karlsbakk problem I got into one quite different myself.
>
> I have a 256MB UP PII 933 MHz.
> When running the included program with an option of 200
> (serving 200 clients with streaming data á 10MB... on first run
> it creates the data, from /dev/urandom - overkill from /dev/null is ok!)
>
> ddteset.sh 200
> [testcase initially written by Roy Sigurd Karlsbakk, he does not get
> into this - but he has more RAM]
>
> the 2.4.18pre7 goes into deep swap after awhile .
> It is impossible to start a new login, et.c. finally
> the dd processes begins to be OOM killed... not nice...
>
> the 2.4.17-rmap12b handles this MUCH nicer!

Roger what happens if you add my patch that allows the shrink
functions to return the number of pages they free?

(patch was posted to lklm sunday, copy sent privatly to Roger)

Ed Tomlinson
