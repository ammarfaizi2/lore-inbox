Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261541AbVEBA3k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261541AbVEBA3k (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 20:29:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261558AbVEBA3k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 20:29:40 -0400
Received: from smcc.demon.nl ([212.238.157.128]:59268 "EHLO smcc.demon.nl")
	by vger.kernel.org with ESMTP id S261541AbVEBA3h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 20:29:37 -0400
From: "Nemosoft Unv." <nemosoft@smcc.demon.nl>
To: Greg Kroah <greg@kroah.com>, luc@saillard.org
Subject: The return of PWC
Date: Mon, 2 May 2005 02:29:35 +0200
User-Agent: KMail/1.7.2
Organization: I'm not organized
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505020229.35129@smcc.demon.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg, Luc

I've been out of the loop for a while, but today I was informed that PWC is 
about to return to the main Linux kernel tree, in some form. In fact, it's 
already in 2.4.12rc3.

Unfortunately, the current implementation is not acceptable. First, there 
are still some references to the old website 
(http://www.smcc.demon.nl/webcam) en e-mail address. But that's no big 
deal. What's more of a problem, though, is the decompressor code that is 
being included.

In case you hadn't noticed, that code has been reverse compiled (I would not 
even call it "reverse engineered"), and is simply illegal. Maybe not in 
every country, but certainly in some. There are still some intellectual 
property rights being violated here, you know, and I'm surprised at the 
contempt you and Linux kernel maintainers show in this regard for a few 
lines of the law.

Now don't get started on "it was GPL code before you left bla bla" or "you 
should not have abonded the project bla bla blah" and "this court here has 
ruled reverse engineering is allowed and so on mumble mumble". 

I abandoned the project, true. But PWC was (and is) GPL, so if somebody  
wanted to do the maintenance, that's fine because that is the intent, after 
all. Even if that person grabbed the pre-compiled binaries and started 
maintaining with that, that would have been borderline, but okay. But 
you're crossing the line here with PWCX (the decompressor). If it was 
truely reverse engineered, by studying the bitstream and trying to figure 
out the algorithms, then that would have been a remarkable feat. But how 
dare you decompile binary code, slap a GPL header on it and try to return 
it to the kernel as if everything's alright now?

Anyway, I'll inform my contacts at Philips tomorrow. I don't know how they 
will react; maybe they'll go nuts, maybe they'll let it pass quitely; it's 
hard to tell. Either way, you're putting yourself in a precarious situation 
here. Clearly, this code was not intended to be included in the kernel 
source, it has been obtained by rather dubious means and, above all, I 
don't think the GPL was ever intended for this kind of "relabelling". I 
call it theft.

So I seriously suggest you do not put the module back into the kernel in 
this form.

Regards,

 - Nemosoft Unv.
