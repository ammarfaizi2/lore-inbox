Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129385AbQLDLNX>; Mon, 4 Dec 2000 06:13:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129413AbQLDLNO>; Mon, 4 Dec 2000 06:13:14 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:47116 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S129385AbQLDLNF>; Mon, 4 Dec 2000 06:13:05 -0500
Message-ID: <3A2B750C.924E6CAB@idb.hist.no>
Date: Mon, 04 Dec 2000 11:42:20 +0100
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: no, da, en
MIME-Version: 1.0
To: Rajeev Bector <rajeev@akamai.com>, linux-kernel@vger.kernel.org
Subject: Re: using TOS as a key in route cache
In-Reply-To: <Pine.LNX.4.10.10011301433470.5925-100000@marjorie.sanmateo.akamai.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rajeev Bector wrote:
> 
> Guys
>  I am looking for a reason as to why we want
> to have different route cache entries for
> different IP ToS types. Does anyone have
> any insight into this ?

Because you may want to route time-critical stuff like
video through a dedicated fast network and slow stuff like email
through another.  Such a setup prevents an email burst from 
disrupting video.

There are many similiar uses.

Helge Hafting
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
