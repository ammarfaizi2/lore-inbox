Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290206AbSA3RJ3>; Wed, 30 Jan 2002 12:09:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290214AbSA3RIb>; Wed, 30 Jan 2002 12:08:31 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:45320 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S290221AbSA3RH3>; Wed, 30 Jan 2002 12:07:29 -0500
Date: Wed, 30 Jan 2002 20:07:27 +0300
From: Oleg Drokin <green@namesys.com>
To: Dave Jones <davej@suse.de>, Sebastian Dr?ge <sebastian.droege@gmx.de>,
        linux-kernel@vger.kernel.org
Subject: Re: Current Reiserfs Update / 2.5.2-dj7 Oops
Message-ID: <20020130200727.A1158@namesys.com>
In-Reply-To: <20020130151420.40e81aef.sebastian.droege@gmx.de> <20020130173715.B2179@namesys.com> <20020130163951.13daca94.sebastian.droege@gmx.de> <20020130190905.A820@namesys.com> <20020130174011.L24012@suse.de> <20020130194408.A2153@namesys.com> <20020130175523.M24012@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020130175523.M24012@suse.de>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Wed, Jan 30, 2002 at 05:55:23PM +0100, Dave Jones wrote:
>  > You do not play with a hdparm in your boot scripts, do you?
>  > I do (will retry without this now).
>  > How about others?
>  No, my testboxes autoconfigure with the right settings.
In fact I am able to reproduce with just bare booting into /bin/bash
remounting reiserfs into rw mode and do depmod -a
Hmmm. Interesting thing is may be only those who have reiserfs as root are
affected? Going to check it now (though scsi system with reiserfs root still
looks fine running stressetsts).

Bye,
    Oleg
