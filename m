Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272094AbRIEK4p>; Wed, 5 Sep 2001 06:56:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272099AbRIEK4f>; Wed, 5 Sep 2001 06:56:35 -0400
Received: from mercury.rus.uni-stuttgart.de ([129.69.1.226]:65033 "EHLO
	mercury.rus.uni-stuttgart.de") by vger.kernel.org with ESMTP
	id <S272094AbRIEK41>; Wed, 5 Sep 2001 06:56:27 -0400
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: getpeereid() for Linux
In-Reply-To: <tgsne23sou.fsf@mercury.rus.uni-stuttgart.de.suse.lists.linux.kernel>
	<oupae0ax8vq.fsf@pigdrop.muc.suse.de>
	<tgu1yi2br5.fsf@mercury.rus.uni-stuttgart.de>
	<20010905124807.A17035@gruyere.muc.suse.de>
From: Florian Weimer <Florian.Weimer@RUS.Uni-Stuttgart.DE>
Date: 05 Sep 2001 12:56:10 +0200
In-Reply-To: <20010905124807.A17035@gruyere.muc.suse.de> (Andi Kleen's message of "Wed, 5 Sep 2001 12:48:07 +0200")
Message-ID: <tgn14929f9.fsf@mercury.rus.uni-stuttgart.de>
User-Agent: Gnus/5.090001 (Oort Gnus v0.01) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> writes:

> SO_PEERCRED doesn't need any cooperation from the other end (at least 
> not for SOCK_STREAM) 

Thanks.  Over here, SO_PEERCRED is documented in socket(7). ;-)

> There is netfilter owner match, but it is a bad hack.

I certainly don't want to give a user process the right to add
netfilter rules dynamically. :-/

> I think you're better off with identd. 

Or some /proc parsing (which is probably what identd does, too).

-- 
Florian Weimer 	                  Florian.Weimer@RUS.Uni-Stuttgart.DE
University of Stuttgart           http://cert.uni-stuttgart.de/
RUS-CERT                          +49-711-685-5973/fax +49-711-685-5898
