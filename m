Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266434AbUG0RlZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266434AbUG0RlZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 13:41:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266479AbUG0RlZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 13:41:25 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:55234 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S266434AbUG0RlX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 13:41:23 -0400
Subject: Re: [PATCH 2.6.8-rc2] intel8x0.c to include CK804 audio support
From: Lee Revell <rlrevell@joe-job.com>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: Paul Jackson <pj@sgi.com>, Andrew Morton <akpm@osdl.org>, achew@nvidia.com,
       linux-kernel <linux-kernel@vger.kernel.org>, jgarzik@pobox.com
In-Reply-To: <200407270943.23292.vda@port.imtp.ilyichevsk.odessa.ua>
References: <DBFABB80F7FD3143A911F9E6CFD477B03F95DD@hqemmail02.nvidia.com>
	 <1090902426.1094.33.camel@mindpipe> <20040726215738.5c4a8b42.pj@sgi.com>
	 <200407270943.23292.vda@port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain
Message-Id: <1090950096.1094.53.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 27 Jul 2004 13:41:36 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-07-27 at 02:43, Denis Vlasenko wrote:
> On Tuesday 27 July 2004 07:57, Paul Jackson wrote:
> > > For now the only fix for people using an X environment ... insert file
> > > ...
> >
> > I'm guessing that the tabs are lost in the cut or copy operation, not in
> > the paste operation.
> 
> because 'cut' in a xterm cannot know that those eight spaces
> once were a tab. xterm is probably storing screen as a char+attr
> two-dimensional array. There are no tabs, only spaces.

Yes, but unless you are copying from vim or emacs, where the editor is
converting tabs to N spaces based on your settings, this is fixable.   
For example it should be possible to run diff from the command line and
copy the output, preserving tabs correctly.  There is an alpha quality
patch floating around to add this functionality to xterm.

But, this is horribly OT.  My main point was that it's almost always not
the mailer's fault if your patches are getting mangled in this way.

Lee

