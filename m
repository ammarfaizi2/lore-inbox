Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131246AbREEJWZ>; Sat, 5 May 2001 05:22:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131588AbREEJWQ>; Sat, 5 May 2001 05:22:16 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:64518 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S131246AbREEJWK>;
	Sat, 5 May 2001 05:22:10 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200105050922.f459M7E252665@saturn.cs.uml.edu>
Subject: Re: Possible README patch
To: duncan@gauldd.freeserve.co.uk (Duncan Gauld)
Date: Sat, 5 May 2001 05:22:07 -0400 (EDT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <01050510040100.05769@pc-62-31-91-153-dn> from "Duncan Gauld" at May 05, 2001 10:04:01 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Duncan Gauld writes:

> Information in the README file says that when patching, the -p0 option is 
> used with patch (eg tar xvzf <patch>.tar.gz | patch -p0). However I have 
> never got this to work as I always get something like "can't find file to 
> patch at line 5". However, replacing -p0 with -p1 seems to work perfectly.
> Maybe the penguin doesn't like me, but still, whenever I've downloaded 
> patches I had to say -p1, not -p0...
...
> -- README	Sat May  5 09:51:36 2001
> +++ README	Sat May  5 09:52:24 2001
> @@ -66,10 +66,10 @@
>     install by patching, get all the newer patch files, enter the
>     directory in which you unpacked the kernel source and execute:

This is ambiguous:
"the directory in which you unpacked the kernel source"

If I do "cd /usr/src" then "tar Ixf linux-2.4.4.tar.bz2",
then where did I unpack the kernel source? I think you could
argue for /usr/src or /usr/src/linux equally well.

