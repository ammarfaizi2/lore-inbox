Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261841AbUKCTfN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261841AbUKCTfN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 14:35:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261836AbUKCTeF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 14:34:05 -0500
Received: from sp-260-1.net4.netcentrix.net ([4.21.254.118]:25488 "EHLO
	asmodeus.mcnaught.org") by vger.kernel.org with ESMTP
	id S261832AbUKCTdL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 14:33:11 -0500
To: gheskett@wdtv.com
Cc: linux-kernel@vger.kernel.org,
       =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>,
       DervishD <lkml@dervishd.net>
Subject: Re: is killing zombies possible w/o a reboot?
References: <200411030751.39578.gene.heskett@verizon.net>
	<200411031353.39468.gene.heskett@verizon.net>
	<yw1x7jp2hi1m.fsf@ford.inprovide.com>
	<200411031424.23149.gheskett@wdtv.com>
From: Doug McNaught <doug@mcnaught.org>
Date: Wed, 03 Nov 2004 14:33:07 -0500
In-Reply-To: <200411031424.23149.gheskett@wdtv.com> (Gene Heskett's message
 of "Wed, 3 Nov 2004 14:24:23 -0500")
Message-ID: <871xfa683w.fsf@asmodeus.mcnaught.org>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/20.7 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett <gheskett@wdtv.com> writes:

> On Wednesday 03 November 2004 14:03, Måns Rullgård wrote:

>>
>>That's because its parent was still sitting around refusing to
>> wait() for them.
>
> Define 'parent' when it was a click on the apps icon on the xwindow 
> screen that started it, please.

Whichever process called fork() to create the app process is the
parent.  Sounds like it's some component of the desktop environment. 

-Doug
