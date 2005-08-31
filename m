Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964940AbVHaXW2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964940AbVHaXW2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 19:22:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964984AbVHaXW2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 19:22:28 -0400
Received: from wproxy.gmail.com ([64.233.184.207]:20125 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964940AbVHaXW1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 19:22:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=Y6hAqLJHbWUEXtqqvsuLDPha9Aepe4r54/066zi1iV5dqOmaJX0C/hma0//lMkDS43jreowq88Ch/Yndfi/rUPQXmO+5JRpv3e2EkXQVo9gOtmPepRL+0APX3EBA0PbfjEEkFnB+zDl3XThL6ZZdASZXb+vF7oWtTH9iQApcsuo=
Date: Thu, 1 Sep 2005 01:22:18 +0200
From: Diego Calleja <diegocg@gmail.com>
To: "Jeff V. Merkey" <jmerkey@soleranetworks.com>
Cc: jmerkey@soleranetworks.com, Valdis.Kletnieks@vt.edu, arjan@infradead.org,
       riel@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] DSFS Network Forensic File System for Linux Patches
Message-Id: <20050901012218.02c79560.diegocg@gmail.com>
In-Reply-To: <431612C3.7020903@soleranetworks.com>
References: <4315DBE7.7080002@soleranetworks.com>
	<Pine.LNX.4.63.0508311432270.16968@cuia.boston.redhat.com>
	<4315E88D.9020603@soleranetworks.com>
	<1125514716.3213.24.camel@laptopd505.fenrus.org>
	<4315F04D.5050705@soleranetworks.com>
	<200508312128.j7VLST47010653@turing-police.cc.vt.edu>
	<431611B7.6000103@soleranetworks.com>
	<431612C3.7020903@soleranetworks.com>
X-Mailer: Sylpheed version 2.1.1+svn (GTK+ 2.8.2; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Wed, 31 Aug 2005 14:27:47 -0600,
"Jeff V. Merkey" <jmerkey@soleranetworks.com> escribió:

>  
> NOTE! This copyright does *not* cover user programs that use kernel
>  services by normal system calls - this is merely considered normal use
>  of the kernel, and does *not* fall under the heading of "derived work".
>  Also note that the GPL below is copyrighted by the Free Software
>  Foundation, but the instance of code that it refers to (the linux
>  kernel) is copyrighted by me and others who actually wrote it.

So, that means that DSFS runs on userspace? (We can't see the source
so it'd be nice to know how DSFS works)

Also, I'm curious about this piece of code on your patch:
ftp://ftp.soleranetworks.com/pub/dsfs/datascout-only-2.6.9-06-28-05.patch

-		printk(KERN_WARNING "%s: module license '%s' taints kernel.\n",
-		       mod->name, license);
+//		printk(KERN_WARNING "%s: module license '%s' taints kernel.\n",
+//		       mod->name, license);

I mean, nvidia people also use propietary code in the kernel (probably
violating the GPL anyway) and don't do such things.



