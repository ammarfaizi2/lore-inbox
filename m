Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266156AbSKFV73>; Wed, 6 Nov 2002 16:59:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266157AbSKFV73>; Wed, 6 Nov 2002 16:59:29 -0500
Received: from harddata.com ([216.123.194.198]:37508 "EHLO mail.harddata.com")
	by vger.kernel.org with ESMTP id <S266156AbSKFV72>;
	Wed, 6 Nov 2002 16:59:28 -0500
Date: Wed, 6 Nov 2002 15:05:26 -0700
From: Michal Jaegermann <michal@harddata.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Werner Almesberger <wa@almesberger.net>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lkcd-general@lists.sourceforge.net, lkcd-devel@lists.sourceforge.net
Subject: Re: [lkcd-devel] Re: What's left over.
Message-ID: <20021106150526.A28533@mail.harddata.com>
References: <Pine.LNX.4.44.0211052203150.1416-100000@home.transmeta.com> <m1znsndtpn.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <m1znsndtpn.fsf@frodo.biederman.org>; from ebiederm@xmission.com on Wed, Nov 06, 2002 at 12:48:36AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2002 at 12:48:36AM -0700, Eric W. Biederman wrote:
> 
> Then I guess the reasonable thing to do is to modify sys_reboot to
> call machine_kexec instead of machine_restart when a kexec_image is
> present.  Or should I add another magic number, and another case to
> sys_reboot?  

Given that "bird-eye" description why not to make a "normal" restart
a particular case of kexec where you just have one kernel loaded
from an external storage?  It does not seem to be that much
different although some issues are skipped or taken for granted.  Or
I am talking nonsense?

   Michal
