Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270000AbRHJUBB>; Fri, 10 Aug 2001 16:01:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270001AbRHJUAv>; Fri, 10 Aug 2001 16:00:51 -0400
Received: from ns.suse.de ([213.95.15.193]:19723 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S270000AbRHJUAh>;
	Fri, 10 Aug 2001 16:00:37 -0400
To: "B. Galliart" <bgallia@orion.it.luc.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: raw device library to provide block alignment
In-Reply-To: <Pine.A41.4.31.0108091157240.59224-100000@orion.it.luc.edu.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 10 Aug 2001 22:00:44 +0200
In-Reply-To: "B. Galliart"'s message of "9 Aug 2001 21:42:01 +0200"
Message-ID: <ouphevfit1v.fsf@pigdrop.muc.suse.de>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"B. Galliart" <bgallia@orion.it.luc.edu> writes:
> 
>   Is anyone working on such a library as I described above?  Or is there
> an easier method?

The standard non raw page cache does what you want.
Basically adding such things kills all the performance benefits raw may 
have. If you want raw you should fix your application to use aligned buffers.

-Andi
