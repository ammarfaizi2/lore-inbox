Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317165AbSHGLrr>; Wed, 7 Aug 2002 07:47:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317170AbSHGLrq>; Wed, 7 Aug 2002 07:47:46 -0400
Received: from cygnus-ext.enyo.de ([212.9.189.162]:65295 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id <S317165AbSHGLrp>;
	Wed, 7 Aug 2002 07:47:45 -0400
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, gam3@acm.org
Subject: Re: Problems with NFS exports
References: <87eldchtr2.fsf@deneb.enyo.de> <87k7n3t3zm.fsf@deneb.enyo.de>
	<15696.63765.38094.618742@notabene.cse.unsw.edu.au>
	<8765ymsyzh.fsf@deneb.enyo.de>
	<15697.511.36832.939913@notabene.cse.unsw.edu.au>
From: Florian Weimer <fw@deneb.enyo.de>
Mail-Followup-To: Neil Brown <neilb@cse.unsw.edu.au>,
 linux-kernel@vger.kernel.org,  gam3@acm.org
Date: Wed, 07 Aug 2002 13:51:22 +0200
In-Reply-To: <15697.511.36832.939913@notabene.cse.unsw.edu.au> (Neil Brown's
 message of "Wed, 7 Aug 2002 21:18:23 +1000")
Message-ID: <87d6surio5.fsf@deneb.enyo.de>
User-Agent: Gnus/5.090007 (Oort Gnus v0.07) Emacs/21.2 (i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown <neilb@cse.unsw.edu.au> writes:

>> > And "BUSY" probably isn't correct ....
>> 
>> Why not? The ressource (the directory tree) is already being used, and
>> therefore the export fails.
>
> I guess... I just feel it isn't really clear what it is that is
> 'busy'.

And it implies that it is just a temporary error condition, not a
configuration issue.

Maybe EEXIST is better?
