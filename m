Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281692AbRKUKf1>; Wed, 21 Nov 2001 05:35:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281599AbRKUKfS>; Wed, 21 Nov 2001 05:35:18 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:20240 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S281563AbRKUKfJ>; Wed, 21 Nov 2001 05:35:09 -0500
Message-ID: <3BFB831F.49284E42@idb.hist.no>
Date: Wed, 21 Nov 2001 11:34:07 +0100
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.4.15-pre7 i686)
X-Accept-Language: no, en
MIME-Version: 1.0
To: Thomas Hood <jdthood@mail.com>, linux-kernel@vger.kernel.org
Subject: Re: x bit for dirs: misfeature?
In-Reply-To: <1006272306.9039.18.camel@thanatos>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Hood wrote:
> 
> Please forgive me if I overlooked the message that
> already said this, but ...
> 
> James Sutherland wrote that "There are valid uses for
> X only directories (i.e. users are not allowed to list
> the contents, only to access them directly by name).
> R-only directories make little sense".  Then there
> followed a long discussion about the utility of "--x"
> directories.  (I agree that they aren't a very good
> idea, since an explorable directory can be "listed" by
> trial and error on the filenames within it.)

Finding filenames by trial and error is hopeless.
It is _much_ easier to find the root
password by trial and error and then change the permissions
and list in the normal way.  
There is only one root password to guess, but you think
having to guess _every_ filename is insecure?

A x-only directory is much safer than user security
will ever be - you effectively have a password per file.

> 
> However, a decent reason for having separate r and x
> is that "r--" directories _do_ make sense.  When a
> directory is "r--", its contents can be _listed_ but the
> directory cannot be browsed.  Observe:     // Thomas Hood

But is that useful?
Sure, I can list filenames.  I can't get at filesize
or permissions.  I can't open the files.  How
is that useful?  Of course locking people
out is useful, but why should they need to read
the filenames?

Helge Hafting
