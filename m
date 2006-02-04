Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932268AbWBDOOV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932268AbWBDOOV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 09:14:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932274AbWBDOOU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 09:14:20 -0500
Received: from uproxy.gmail.com ([66.249.92.198]:34100 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932268AbWBDOOU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 09:14:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=F+bvyNdm0fy7nMi0ul6VGpeMoTMoKY3p9hyfOG9BKr1c1nV1edScsIgeVC2pWm40tmKSrXLzrEcMun5/TM+BqmuB5XCqnoh4FKJTqImeIm2LaDK5YS7A4MDXbPsza3OcIy1RlYTynEkIfjVaO9If21JWsFMRtpd6sMUjsGLa5AU=
Date: Sat, 4 Feb 2006 15:14:11 +0100
From: Diego Calleja <diegocg@gmail.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: ryan@michonline.com, Larry.Finger@lwfinger.net, ornati@fastwebnet.it,
       linux-kernel@vger.kernel.org
Subject: Re: Linux v2.6.16-c2
Message-Id: <20060204151411.4b977e4e.diegocg@gmail.com>
In-Reply-To: <Pine.LNX.4.64.0602031809010.3969@g5.osdl.org>
References: <43E39932.4000001@lwfinger.net>
	<Pine.LNX.4.64.0602031007420.4630@g5.osdl.org>
	<43E3A001.7080309@lwfinger.net>
	<20060203205716.7ed38386@localhost>
	<43E3BF5A.3040305@lwfinger.net>
	<Pine.LNX.4.64.0602031258300.4630@g5.osdl.org>
	<43E3C703.20501@lwfinger.net>
	<20060203235002.GA5580@mythryan2.michonline.com>
	<20060204013522.3656f4f6.diegocg@gmail.com>
	<Pine.LNX.4.64.0602031809010.3969@g5.osdl.org>
X-Mailer: Sylpheed version 2.1.9 (GTK+ 2.8.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Fri, 3 Feb 2006 18:16:44 -0800 (PST),
Linus Torvalds <torvalds@osdl.org> escribió:


> Did you perhaps do a ^C in frustration when you first did the rsync: pull, 
> and noticed that it was going to pull the whole big new pack-file?

I used the native git:// protocol. I'm on a dialup connection. Maybe the
link disconnected while I was doing "git pull" and I didn't noticed it.


> 	git fsck-objects --full
> 
> which will do a full fsck and warn about anything it finds.

It seems that this repository is definitively corrupted, so I think
I'll just download a new copy :/

broken link from    tree 26dcdcda6e1cb010730d3bd9caa3e5e9209be767
              to    blob f769872debea6e09f1511f1e86558ed4ce50af9e
broken link from    tree 26dcdcda6e1cb010730d3bd9caa3e5e9209be767
              to    blob a85e16f56d73672dce8de3c61a4ee7de68028c15
broken link from    tree 26dcdcda6e1cb010730d3bd9caa3e5e9209be767
              to    blob c631c082f8f7d281464f7eb8c5df07791e2836ab
broken link from    tree 26dcdcda6e1cb010730d3bd9caa3e5e9209be767
              to    blob f942fcc218312ec70d6eb9d1793ba43cd98ad355
missing blob 26dfa9e216c2814f9419b318ed8289e46f6b8a21
missing blob 26e421498c973dc3c539263d8d6d19431ef14bc2
missing blob 26eac194064b8a2851705db6cfa3bd1bd5bc5e8a
missing tree 26eb17786227897888ff6447389e979f2e2f3586
missing blob 26ee81bbd6c64e4d2ace3ad5eec300b783facf0b
missing blob 26f17e3fc45c6113b99e138dde03138502e85b4d
missing blob 26f293ab96178e22034626adf5fdae747e08f557
missing blob 26f5d7bb9a418d59c6d766388b4320ad26f63035
missing blob 26f67cccc37c3c4dd31164ba3499572ffa937d49
broken link from    tree 26f78f3e3a0156b75c84ef01d61130454bc4e673
              to    tree f7a02df4242f09f713b70b1f8e74dbf7f0068566
broken link from    tree 26f78f3e3a0156b75c84ef01d61130454bc4e673
              to    tree c4ec76f4e8721e4b5b9651dac62c233980fc9d78
broken link from    tree 26f78f3e3a0156b75c84ef01d61130454bc4e673
              to    tree c16336297d8ad2117b98126f32cc0fdeb42f94eb
broken link from    tree 26f78f3e3a0156b75c84ef01d61130454bc4e673
              to    tree 7b9962eb29d2b41bd58bb1dd0be529c73bf08012
broken link from    tree 26f78f3e3a0156b75c84ef01d61130454bc4e673
              to    tree 3a8587c8c755788804b430cc332a1aecebf389d4
broken link from    tree 26f78f3e3a0156b75c84ef01d61130454bc4e673
              to    tree f0a90cc615da5833d95ff5cb2c96e44d20893de6
broken link from    tree 26f78f3e3a0156b75c84ef01d61130454bc4e673
              to    tree 0a8763981774041f3fee0a71e016dcaa096fa3f8
broken link from    tree 26f78f3e3a0156b75c84ef01d61130454bc4e673
              to    tree c1416c92121e10ef4a8d0450133a9e92c90cc9c9
broken link from    tree 26f78f3e3a0156b75c84ef01d61130454bc4e673
              to    tree 38585f38d977552fbcbc30885c6e02a707adfdeb
broken link from    tree 26f78f3e3a0156b75c84ef01d61130454bc4e673
              to    tree 73cc6db7bf26213d2768966a3bfa03d8ccb9f6cf

[thousand of warnings like this]
