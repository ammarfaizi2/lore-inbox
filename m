Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262237AbVEYC0Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262237AbVEYC0Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 22:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262240AbVEYC0Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 22:26:25 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:29603 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262237AbVEYC0S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 22:26:18 -0400
Subject: Re: RT patch acceptance
From: Lee Revell <rlrevell@joe-job.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Sven Dietrich <sdietrich@mvista.com>, dwalker@mvista.com, bhuey@lnxw.com,
       nickpiggin@yahoo.com.au, mingo@elte.hu, hch@infradead.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050524192029.2ef75b89.akpm@osdl.org>
References: <4292DFC3.3060108@yahoo.com.au> <20050524081517.GA22205@elte.hu>
	 <4292E559.3080302@yahoo.com.au> <20050524090240.GA13129@elte.hu>
	 <4292F074.7010104@yahoo.com.au>
	 <1116957953.31174.37.camel@dhcp153.mvista.com>
	 <20050524224157.GA17781@nietzsche.lynx.com>
	 <1116978244.19926.41.camel@dhcp153.mvista.com>
	 <20050525001019.GA18048@nietzsche.lynx.com>
	 <1116981913.19926.58.camel@dhcp153.mvista.com>
	 <20050525005942.GA24893@nietzsche.lynx.com>
	 <1116982977.19926.63.camel@dhcp153.mvista.com>
	 <20050524184351.47d1a147.akpm@osdl.org> <4293DCB1.8030904@mvista.com>
	 <20050524192029.2ef75b89.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 24 May 2005 22:26:16 -0400
Message-Id: <1116987976.2912.110.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-05-24 at 19:20 -0700, Andrew Morton wrote:
> Sven Dietrich <sdietrich@mvista.com> wrote:
> >
> > I think people would find their system responsiveness / tunability
> >  goes up tremendously, if you drop just a few unimportant IRQs into
> >  threads.
> 
> People cannot detect the difference between 1000usec and 50usec latencies,
> so they aren't going to notice any changes in responsiveness at all.

The IDE IRQ handler can in fact run for several ms, which people sure
can detect.

Lee

