Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314381AbSDRRvq>; Thu, 18 Apr 2002 13:51:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314400AbSDRRvp>; Thu, 18 Apr 2002 13:51:45 -0400
Received: from ns.suse.de ([213.95.15.193]:29188 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S314381AbSDRRvo>;
	Thu, 18 Apr 2002 13:51:44 -0400
To: Paul Mackerras <paulus@samba.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] 2.5.8 sort kernel tables
In-Reply-To: <1589.1019123186@ocs3.intra.ocs.com.au.suse.lists.linux.kernel> <15550.50131.489249.256007@nanango.paulus.ozlabs.org.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 18 Apr 2002 19:51:43 +0200
Message-ID: <p738z7kao9c.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Mackerras <paulus@samba.org> writes:
> 
> BTW, do you have any valid examples of use of copy_to/from_user or
> get/put_user in an init section?

i386 uses the exception tables to check at startup for the old i386 bug of 
pages not being  write protected when writing from supervisor mode. That 
function is __init.

-Andi

