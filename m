Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135353AbRDRVb1>; Wed, 18 Apr 2001 17:31:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135354AbRDRVbS>; Wed, 18 Apr 2001 17:31:18 -0400
Received: from ns.suse.de ([213.95.15.193]:49681 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S135353AbRDRVbH>;
	Wed, 18 Apr 2001 17:31:07 -0400
Date: Wed, 18 Apr 2001 23:31:00 +0200
From: Andi Kleen <ak@suse.de>
To: Joel Eriksson <jen@ettnet.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Socket hack question.
Message-ID: <20010418233100.A10393@gruyere.muc.suse.de>
In-Reply-To: <20010419002852.A24647@seth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010419002852.A24647@seth>; from jen@ettnet.se on Thu, Apr 19, 2001 at 12:28:52AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2001 at 12:28:52AM +0200, Joel Eriksson wrote:
> Hello,
> 
> I am a kernel hacking newbie and am struggling to understand the
> networking subsystem. I would like to be able to add a systemcall,
> preferably asynchronous, that connects a socket with a filedescriptor
> (proxy(srcsd, dstfd)) so that everything received on srcsd is directly
> written to dstfd. The proxy should close when srcsd is closed or when
> a zero-size packet is sent (or something like that..).

That syscall already exists -- it's called sendfile. 

-Andi
