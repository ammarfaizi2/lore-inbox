Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261838AbTCLRzW>; Wed, 12 Mar 2003 12:55:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261839AbTCLRzW>; Wed, 12 Mar 2003 12:55:22 -0500
Received: from faui3es.informatik.uni-erlangen.de ([131.188.33.16]:24555 "EHLO
	faui3es.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id <S261838AbTCLRzV>; Wed, 12 Mar 2003 12:55:21 -0500
Date: Wed, 12 Mar 2003 19:05:50 +0100
From: Martin Waitz <tali@admingilde.org>
To: Niels Provos <provos@citi.umich.edu>
Cc: Davide Libenzi <davidel@xmailserver.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hanna Linder <hannal@us.ibm.com>, Janet Morgan <janetmor@us.ibm.com>,
       Marius Aamodt Eriksen <marius@citi.umich.edu>,
       Shailabh Nagar <nagar@watson.ibm.com>
Subject: Re: [patch, rfc] lt-epoll ( level triggered epoll ) ...
Message-ID: <20030312180550.GA27366@admingilde.org>
Mail-Followup-To: Niels Provos <provos@citi.umich.edu>,
	Davide Libenzi <davidel@xmailserver.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Hanna Linder <hannal@us.ibm.com>,
	Janet Morgan <janetmor@us.ibm.com>,
	Marius Aamodt Eriksen <marius@citi.umich.edu>,
	Shailabh Nagar <nagar@watson.ibm.com>
References: <Pine.LNX.4.50.0303101139520.1922-100000@blue1.dev.mcafeelabs.com> <20030311043202.GK2225@citi.citi.umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030311043202.GK2225@citi.citi.umich.edu>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi :)

On Mon, Mar 10, 2003 at 11:32:02PM -0500, Niels Provos wrote:
> It seems that option 3) which implements both "edge" and "level"
> triggered behavior is the best solution.  This is similar to kqueue
> which supports both triggering modes.
imho the kqueue api is a lot nicer anyway.

what about simply implementing kqueue?
it's already available in other OS's,
so it's easier for application developers to adopt it, too.

-- 
CU,		  / Friedrich-Alexander University Erlangen, Germany
Martin Waitz	//  [Tali on IRCnet]  [tali.home.pages.de] _________
______________/// - - - - - - - - - - - - - - - - - - - - ///
dies ist eine manuell generierte mail, sie beinhaltet    //
tippfehler und ist auch ohne grossbuchstaben gueltig.   /
			    -
Wer bereit ist, grundlegende Freiheiten aufzugeben, um sich 
kurzfristige Sicherheit zu verschaffen, der hat weder Freiheit 
noch Sicherheit verdient.            Benjamin Franklin (1706 - 1790)
