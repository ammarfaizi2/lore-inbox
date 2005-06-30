Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262799AbVF3DE5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262799AbVF3DE5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 23:04:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262800AbVF3DE4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 23:04:56 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:29174 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262799AbVF3DEx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 23:04:53 -0400
Message-ID: <42C3615A.9020600@namesys.com>
Date: Wed, 29 Jun 2005 20:04:58 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ross Biro <ross.biro@gmail.com>
CC: Hubert Chan <hubert@uhoreg.ca>, Horst von Brand <vonbrand@inf.utfsm.cl>,
       Kyle Moffett <mrmacman_g4@mac.com>, David Masover <ninja@slaphack.com>,
       Valdis.Kletnieks@vt.edu, Lincoln Dale <ltd@cisco.com>,
       Gregory Maxwell <gmaxwell@gmail.com>, Jeff Garzik <jgarzik@pobox.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
References: <hubert@uhoreg.ca>	 <200506290509.j5T595I6010576@laptop11.inf.utfsm.cl>	 <87hdfgvqvl.fsf@evinrude.uhoreg.ca> <8783be6605062914341bcff7cb@mail.gmail.com>
In-Reply-To: <8783be6605062914341bcff7cb@mail.gmail.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ross Biro wrote:

>On 6/29/05, Hubert Chan <hubert@uhoreg.ca> wrote:
>  
>
>>On Wed, 29 Jun 2005 01:09:05 -0400, Horst von Brand <vonbrand@inf.utfsm.cl> said:
>>
>>    
>>
>>>Hubert Chan <hubert@uhoreg.ca> wrote: [...]
>>>And doing "tar cf /dev/tape /usr/games/tetris" gives you a nice tangle
>>>of undecipherable junk.
>>>      
>>>
>
>I'm confused.  Can someone on one of these lists enlighten me?
>
>How is directories as files logically any different than putting all
>data into .data files and making all files directories (yes you would
>need some sort of special handling for files that were really called
>.data). 
>
Add to this that you make .data the default if the file within the
directory is not specified, and define a stanadard set of names for
metafiles, and you've got the essential idea, and any differences are
details.

> Then it's just a matter of deciding what happens when you
>call open and stat on one of these files?
>
>For backwards compatibility, current existing system calls have to
>treat these things as directories.  Perhaps an exception could be made
>for exec.
>
>But we could have a whole new set of system calls that treat things as
>magic, and if files as directories is as cool as many people think,
>apps will start using the new api.  If not, they won't and the new api
>can be deprecated.
>
>    Ross
>
>
>  
>

