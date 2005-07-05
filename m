Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262009AbVGEWIa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262009AbVGEWIa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 18:08:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261990AbVGEWHN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 18:07:13 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:27636 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261963AbVGEWBZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 18:01:25 -0400
Message-ID: <42CB0328.3070706@namesys.com>
Date: Tue, 05 Jul 2005 15:01:12 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hubert Chan <hubert@uhoreg.ca>
CC: David Masover <ninja@slaphack.com>, Ross Biro <ross.biro@gmail.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Kyle Moffett <mrmacman_g4@mac.com>, Valdis.Kletnieks@vt.edu,
       Lincoln Dale <ltd@cisco.com>, Gregory Maxwell <gmaxwell@gmail.com>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
References: <hubert@uhoreg.ca>	<200506290509.j5T595I6010576@laptop11.inf.utfsm.cl>	<87hdfgvqvl.fsf@evinrude.uhoreg.ca>	<8783be6605062914341bcff7cb@mail.gmail.com>	<878y0svj1h.fsf@evinrude.uhoreg.ca> <42C4F97B.1080803@slaphack.com> <87ll4lynky.fsf@evinrude.uhoreg.ca>
In-Reply-To: <87ll4lynky.fsf@evinrude.uhoreg.ca>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hubert Chan wrote:

>On Fri, 01 Jul 2005 03:06:19 -0500, David Masover <ninja@slaphack.com> said:
>
>  
>
>>Hubert Chan wrote:
>>    
>>
>
>  
>
>>>The main thing blocking file-as-dir is that there are some
>>>locking(IIRC?) issues.  And, of course, some people wouldn't want it
>>>to be merged into the mainline kernel.  (Of course, the latter
>>>doesn't prevent Namesys from maintaining their own patches for people
>>>to play around with.)
>>>      
>>>
>
>  
>
>>What's the locking issue?  I think that was more about transactions...
>>    
>>
>
>It was whatever was Al Viro's (technical) complaint about file-as-dir.
>I don't remember exactly what it was.  The technical people know what it
>is (and the Namesys guys are probably working on it), and the exact
>issue doesn't concern us non-technical people that much, so I don't feel
>like looking it up.  But if you want to, just look for Al Viro's message
>in this thread.
>
>  
>
Cycle detection when hard links to directories are allowed.  There is a
debate over whether cycle detection is feasible that can only be
resolved by working code or a formal proof that it is not
computationally feasible.

Hans
