Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318887AbSICT7m>; Tue, 3 Sep 2002 15:59:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318894AbSICT7m>; Tue, 3 Sep 2002 15:59:42 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:42480 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S318887AbSICT7l>; Tue, 3 Sep 2002 15:59:41 -0400
Date: Tue, 3 Sep 2002 16:04:14 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Daniel Phillips <phillips@arcor.de>
Cc: Neil Brown <neilb@cse.unsw.edu.au>, Pavel Machek <pavel@suse.cz>,
       Peter Chubb <peter@chubb.wattle.id.au>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: Large block device patch, part 1 of 9
Message-ID: <20020903160414.K21268@redhat.com>
References: <15717.52317.654149.636236@wombat.chubb.wattle.id.au> <E17mJZh-0005jw-00@starship> <20020903155045.J21268@redhat.com> <E17mJsl-0005k6-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E17mJsl-0005k6-00@starship>; from phillips@arcor.de on Tue, Sep 03, 2002 at 10:02:38PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2002 at 10:02:38PM +0200, Daniel Phillips wrote:
> If you must have a clever macro:
> 
>    #define lli(foo) (long long int) (foo)
>    #define llu(foo) (long long unsigned) (foo)
> 
> The %lli/%llu have to be there in the format string (modulo as-yet-uninvented
> printk hackery) so the cast might as well be there as well.

Do you not read the messages in a thread before posting?

	static inline long long llsect(sector_t sect) { return sect; }

was the suggestion.

		-ben
-- 
"You will be reincarnated as a toad; and you will be much happier."
