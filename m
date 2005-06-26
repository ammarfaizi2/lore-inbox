Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261388AbVFZBD3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261388AbVFZBD3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Jun 2005 21:03:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261385AbVFZBD2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Jun 2005 21:03:28 -0400
Received: from rwcrmhc14.comcast.net ([216.148.227.89]:41131 "EHLO
	rwcrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S261354AbVFZBDH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Jun 2005 21:03:07 -0400
Message-ID: <42BDFEC7.5010400@namesys.com>
Date: Sat, 25 Jun 2005 18:03:03 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Theodore Ts'o" <tytso@mit.edu>
CC: Pekka Enberg <penberg@cs.helsinki.fi>, Jens Axboe <axboe@suse.de>,
       Andrew Morton <akpm@osdl.org>, Jeff Mahoney <jeffm@suse.de>,
       penberg@gmail.com, ak@suse.de, flx@namesys.com, zam@namesys.com,
       vs@thebsh.namesys.com, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com
Subject: Re: -mm -> 2.6.13 merge status
References: <p73d5qgc67h.fsf@verdi.suse.de> <42B86027.3090001@namesys.com> <20050621195642.GD14251@wotan.suse.de> <42B8C0FF.2010800@namesys.com> <84144f0205062223226d560e41@mail.gmail.com> <42BB0151.3030904@suse.de> <20050623114318.5ae13514.akpm@osdl.org> <20050623193247.GC6814@suse.de> <1119717967.9392.2.camel@localhost> <42BDAF3D.6060809@namesys.com> <20050625210820.GA26946@thunk.org>
In-Reply-To: <20050625210820.GA26946@thunk.org>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Ts'o wrote:

>On Sat, Jun 25, 2005 at 12:23:41PM -0700, Hans Reiser wrote:
>  
>
>>>>       assert("trace_hash-89", is_hashed(foo) != 0);
>>>>
>>>>        
>>>>
>>Lots of people like corporate anonymity.  Some don't.  I don't.  I like
>>knowing who wrote what.  It helps me know who to pay how much.  It helps
>>me know who to forward the bug report to.   Losing your anonymity
>>exposes you, mostly for better since more communication is on balance a
>>good thing, but the fear is there for some.  I don't think we can agree
>>on this, it is an issue of the soul. 
>>    
>>
>
>Fallacy.
>
>The assert doesn't tell you who is at fault; it tells you who placed
>the assert which triggered; it could have triggered due to bugs caused
>by anyone, including the propietary binary-only module from Nvidia
>which the user loaded into his system....
>
>						- Ted
>
>
>  
>
If you read the thread again carefully, you will see that I already said
that it doesn't tell you who is at fault for the bug. Furthermore, I
said that the basis of the resistance of some developers to the use of
this is that they are not fully convinced that others understand that it
identifies only the assertion writer not the bug writer. As the boss of
the guys writing these assertions, I see no reason to indulge baseless
fears. When guys become experienced members of our team, they lose this
fear. Sending the bug report to the assertion writer often works nicely
as a first step, in my project, in my experience, in the cases where I
don't know anything about the likely implications of the assertion myself.
