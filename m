Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270784AbRHSVME>; Sun, 19 Aug 2001 17:12:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270787AbRHSVLy>; Sun, 19 Aug 2001 17:11:54 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:20232 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S270784AbRHSVLt>;
	Sun, 19 Aug 2001 17:11:49 -0400
Date: Sun, 19 Aug 2001 17:15:58 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>, gars@lanm-pc.com
Subject: Re: Swap size for a machine with 2GB of memory
Message-ID: <20010819171558.A9057@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Linux Kernel List <linux-kernel@vger.kernel.org>, gars@lanm-pc.com
In-Reply-To: <20010819024233.A26916@thyrsus.com> <m11ym7ojvw.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <m11ym7ojvw.fsf@frodo.biederman.org>; from ebiederm@xmission.com on Sun, Aug 19, 2001 at 02:49:23PM -0600
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman <ebiederm@xmission.com>:
> There is no magic formula for calculating the amount of swap space
> needed.  It really needs to be sized to the expected load on your box
> plus some.  If you seriously expect to be using swap,  have swapsize >
> memsize and figure the amount of virtual memory you have is swapsize.
> 
> With respect to swap partitions the current limit is about 64Gig.
> You can actually make a larger swap partition but the kernel on x86
> only uses 24 offset bits into that partition.  The 128MB partition
> existed but was removed long ago.

That's helpful, thanks.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

Never trust a man who praises compassion while pointing a gun at you.
