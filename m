Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267355AbTACA1t>; Thu, 2 Jan 2003 19:27:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267356AbTACA1t>; Thu, 2 Jan 2003 19:27:49 -0500
Received: from smtp07.iddeo.es ([62.81.186.17]:56994 "EHLO smtp07.retemail.es")
	by vger.kernel.org with ESMTP id <S267355AbTACA1s>;
	Thu, 2 Jan 2003 19:27:48 -0500
Date: Fri, 3 Jan 2003 01:36:17 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>
Subject: Re: __NR_exit_group for 2.4-O(1)
Message-ID: <20030103003617.GC1539@werewolf.able.es>
References: <20030103001522.GA1539@werewolf.able.es> <20030103003244.A10586@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20030103003244.A10586@infradead.org>; from hch@infradead.org on Fri, Jan 03, 2003 at 01:32:44 +0100
X-Mailer: Balsa 2.0.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2003.01.03 Christoph Hellwig wrote:
> On Fri, Jan 03, 2003 at 01:15:22AM +0100, J.A. Magallon wrote:
> > Hi all...
> > 
> > I am running glibc-2.3.1 on top of a hacked 2.4.21-pre2+aa, and all programs
> > show a curious message at exit when straced:
> 
> Maybe it would be a better idea to complain to the glibc folks?
> 

Oh, no complain, just trying to add one more feature to 2.4 ;)

> Your libc isn't the one from RH's new beta, is it? :)
> 

Nope, Mandrake Cooker glibc-2.3.1-6.
I understand it is a glibc bug, it should detect at build time if the call
is available and omit it in 2.4...

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.1 (Cooker) for i586
Linux 2.4.21-pre2-jam2 (gcc 3.2.1 (Mandrake Linux 9.1 3.2.1-2mdk))
