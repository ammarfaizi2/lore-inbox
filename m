Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965170AbWIRA3u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965170AbWIRA3u (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 20:29:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965171AbWIRA3u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 20:29:50 -0400
Received: from wx-out-0506.google.com ([66.249.82.238]:46990 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S965170AbWIRA3t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 20:29:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=utFEIcl6L4qGPKNhTlqCV7eTKcRZi39ynQpRvyLxAyPlKpOIToztHgu1J78AukdIhUJ/36de67XqfDh1XeJ2tmNh79033WsAMGN7QD9V9jvyelNY2P2FuIcgHfji7DJVoEzB9E9zbUBC2poijehngHMFE5i0iUNMVVbnY7Xn8zo=
Message-ID: <9a8748490609171729y2a17a4f0wad3ed425dbb85425@mail.gmail.com>
Date: Mon, 18 Sep 2006 02:29:48 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Keith Chew" <keith.chew@gmail.com>
Subject: Re: Crash on boot after abrupt shutdown
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20f65d530609161930m2311974esfeaa2fbc2592e49f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20f65d530609161930m2311974esfeaa2fbc2592e49f@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/09/06, Keith Chew <keith.chew@gmail.com> wrote:
> Hi
>
> We are using linux in quite a harsh mobile environment (high
> temperatures, unreliable power sources, electrical interference, etc).
>
> It has been doing very well, except for this scenario. The wireless
> interface wlan0 is busy communicating, and the power is disconnected
> abruptedly. In the next boot, we get a kernel panic when the wlan
> interface is initialised.
>
> We want to know if this is due to linux's journaling file system (we
> are using ext3)? Does it keep track of the state so closely, even up
> to the point of the previous abrupt shutdown? If so, what can we do to
> "cleanup" in the next boot to avoid the kernel panic?
>

You could start by posting your panic/Oops message. That would give
people something to work with.
Perhaps also a bit more detail on the system in question - see the
REPORTING-BUGS document in the kernel source dir.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
