Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316599AbSIDX7u>; Wed, 4 Sep 2002 19:59:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316601AbSIDX7u>; Wed, 4 Sep 2002 19:59:50 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:29172 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S316599AbSIDX7u>; Wed, 4 Sep 2002 19:59:50 -0400
Date: Wed, 4 Sep 2002 20:04:24 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Peter Chubb <peter@chubb.wattle.id.au>
Cc: Daniel Phillips <phillips@arcor.de>, Neil Brown <neilb@cse.unsw.edu.au>,
       Pavel Machek <pavel@suse.cz>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: Large block device patch, part 1 of 9
Message-ID: <20020904200424.O1394@redhat.com>
References: <825516963@toto.iv> <15734.37217.686498.162782@wombat.chubb.wattle.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <15734.37217.686498.162782@wombat.chubb.wattle.id.au>; from peter@chubb.wattle.id.au on Thu, Sep 05, 2002 at 09:04:01AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2002 at 09:04:01AM +1000, Peter Chubb wrote:
> Unfortunately, this doesn't really buy you much ---- standard C type
> promotion rules mean that whatever (within reason) you pass to
> llsect() will work without warning.

Not if someone changes a variable to a pointer by accident without 
updating the printk.  It does happen.

		-ben
-- 
"You will be reincarnated as a toad; and you will be much happier."
