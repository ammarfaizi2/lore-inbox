Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266281AbUG0GoY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266281AbUG0GoY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 02:44:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266287AbUG0GoW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 02:44:22 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:2052 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S266281AbUG0GoJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 02:44:09 -0400
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Paul Jackson <pj@sgi.com>, Lee Revell <rlrevell@joe-job.com>
Subject: Re: [PATCH 2.6.8-rc2] intel8x0.c to include CK804 audio support
Date: Tue, 27 Jul 2004 09:43:23 +0300
X-Mailer: KMail [version 1.4]
Cc: akpm@osdl.org, achew@nvidia.com, linux-kernel@vger.kernel.org,
       jgarzik@pobox.com
References: <DBFABB80F7FD3143A911F9E6CFD477B03F95DD@hqemmail02.nvidia.com> <1090902426.1094.33.camel@mindpipe> <20040726215738.5c4a8b42.pj@sgi.com>
In-Reply-To: <20040726215738.5c4a8b42.pj@sgi.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200407270943.23292.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 27 July 2004 07:57, Paul Jackson wrote:
> > For now the only fix for people using an X environment ... insert file
> > ...
>
> Another fix is to copy from a non-brain damaged window, such as a gui
> text editor window (nedit, for example).
>
> I'm guessing that the tabs are lost in the cut or copy operation, not in
> the paste operation.

because 'cut' in a xterm cannot know that those eight spaces
once were a tab. xterm is probably storing screen as a char+attr
two-dimensional array. There are no tabs, only spaces.

> But file insertion is, in general, a sufficiently winning choice that I
> think it's better just to get in the habit of always inserting patches
> that way, at least on email clients that support it.

I do it all the time.
-- 
vda
