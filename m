Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280212AbRJaNUq>; Wed, 31 Oct 2001 08:20:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280210AbRJaNUh>; Wed, 31 Oct 2001 08:20:37 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:19726 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S280196AbRJaNUX>; Wed, 31 Oct 2001 08:20:23 -0500
Date: Wed, 31 Oct 2001 14:19:18 +0100
From: Jan Kara <jack@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "David S. Miller" <davem@redhat.com>, jgarzik@mandrakesoft.com,
        miles@megapathdsl.net, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: Re: What is standing in the way of opening the 2.5 tree?
Message-ID: <20011031141918.C905@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20011030192902.B22781@atrey.karlin.mff.cuni.cz> <E15yhv5-0001YY-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E15yhv5-0001YY-00@the-village.bc.nu>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >   The second patch is patch which implements new quota format. It makes
> > changes in quotactl() interface and other changes visible in userspace.
> > I think that is the reason why Linus doesn't want it in 2.4 and I agree with him.
> 
> The problem is that without it 32bit uids are useless. That means any real
> world ldap using customer can't use Linus quotas.
> 
> I'd really like to figure a way the code can handle both at once
  In principle both formats can exist in one kernel. The problem is how
to fit them into quotactl() syscall and don't bloat it too much. I'll try to
write something...

									Honza

--
Jan Kara <jack@suse.cz>
SuSE CR Labs
