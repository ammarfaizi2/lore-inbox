Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261652AbVBOIfP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261652AbVBOIfP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 03:35:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261647AbVBOIfP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 03:35:15 -0500
Received: from rproxy.gmail.com ([64.233.170.199]:46061 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261652AbVBOIe7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 03:34:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=re2njT7+oovtCDg529pm9MEAJFHRq+OzhJChFJI2P1YRD381HJB/UQlgF2wmLFj6HF6RGqS0GVSuEXLsE1VeHBpCUBYKGAB5zorOFgGzIsQysy6sNzx3QbQjCr0B3/pp5wD6UJEbqx4E/l1Xmd4Z3GF0/+fNWjAJTkKYXZf98Ew=
Message-ID: <4d8e3fd305021500346503585b@mail.gmail.com>
Date: Tue, 15 Feb 2005 09:34:56 +0100
From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Reply-To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
To: lgb@lgb.hu
Subject: Re: [OT] speeding boot process (was Re: [ANNOUNCE] hotplug-ng 001 release)
Cc: Kyle Moffett <mrmacman_g4@mac.com>, Lee Revell <rlrevell@joe-job.com>,
       Patrick McFarland <pmcfarland@downeast.net>,
       linux-kernel@vger.kernel.org, Tim Bird <tim.bird@am.sony.com>,
       Prakash Punnoor <prakashp@arcor.de>,
       linux-hotplug-devel@lists.sourceforge.net, Greg KH <gregkh@suse.de>,
       Roland Dreier <roland@topspin.com>
In-Reply-To: <20050215073222.GB26950@vega.lgb.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
References: <20050211011609.GA27176@suse.de>
	 <4d8e3fd305021400323fa01fff@mail.gmail.com> <42106685.40307@arcor.de>
	 <1108422240.28902.11.camel@krustophenia.net>
	 <524qge20e2.fsf@topspin.com>
	 <1108424720.32293.8.camel@krustophenia.net>
	 <42113F6B.1080602@am.sony.com>
	 <1108430245.32293.16.camel@krustophenia.net>
	 <4B923A81-7EF3-11D9-86CC-000393ACC76E@mac.com>
	 <20050215073222.GB26950@vega.lgb.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Feb 2005 08:32:22 +0100, Gábor Lénárt <lgb@lgb.hu> wrote:
> On Mon, Feb 14, 2005 at 08:45:39PM -0500, Kyle Moffett wrote:
> > >last thing that gets run.  There is just no reason for this.  We should
> > >start X and initialize the display and get the login prompt up there
> > >ASAP, and let the system acquire the DHCP lease and start sendmail and
> > >apache and get the date from the NTP server *in the background while I
> > >am logging in*.  It's not rocket science.
> >
> > Such a system needs a drastically different bootup process than
> > currently
> > exists, including the ability to specify init-script dependencies.
> > (Like
> 
> Ok, so see Gentoo. Exactly fits your needs, it seems ;-) Dependencies are
> supported, even paralell execution of init scripts are supported by default
> design (you need to change only one setting to do this, IMHO, in
> /etc/conf.d/rc). So it is already solved if you talking about the paralell
> execution with dependency info in init scripts ...

So... why is Gentoo the only distro the uses parallel execution of
init scripts ?

-- 
Paolo <paolo dot ciarrocchi at gmail dot com>
msn: paolo407@hotmail.com
hello: ciarrop
