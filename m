Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268252AbTALHMC>; Sun, 12 Jan 2003 02:12:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268253AbTALHMC>; Sun, 12 Jan 2003 02:12:02 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:51461 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S268252AbTALHMB>;
	Sun, 12 Jan 2003 02:12:01 -0500
Date: Sat, 11 Jan 2003 23:19:47 -0800
From: Greg KH <greg@kroah.com>
To: Scott Murray <scottm@somanetworks.com>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Grant Grundler <grundler@cup.hp.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Paul Mackerras <paulus@samba.org>,
       davidm@hpl.hp.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2.5] 2-pass PCI probing, generic part
Message-ID: <20030112071947.GA29841@kroah.com>
References: <20030111004239.A757@localhost.park.msu.ru> <Pine.LNX.4.44.0301111346200.9854-100000@rancor.yyz.somanetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301111346200.9854-100000@rancor.yyz.somanetworks.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 11, 2003 at 02:39:47PM -0500, Scott Murray wrote:
> 
> Since the lack of resource reservation currently is keeping CompactPCI
> hot insertion from working properly, I have a strong interest in getting
> something in place before 2.6.  I've got a completely manual (kernel
> command-line parameter controlled) reservation patch[1] against 2.4 that
> I could start updating, but I've always thought there must be a more 
> elegant way to do things than the somewhat crude fixup approach I used
> in it.  I'm willing to try coding up something if you or anyone else
> have some ideas as to what would be an acceptable solution.

Didn't people say that your reservation patch looked fine for 2.5?
But that was a while ago, and you never sent it...  :)

thanks,

greg k-h
