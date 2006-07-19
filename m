Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030274AbWGSUXc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030274AbWGSUXc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 16:23:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030275AbWGSUXc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 16:23:32 -0400
Received: from ns2.osuosl.org ([140.211.166.131]:14554 "EHLO ns2.osuosl.org")
	by vger.kernel.org with ESMTP id S1030274AbWGSUXb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 16:23:31 -0400
Date: Wed, 19 Jul 2006 16:23:33 -0400
From: Brandon Philips <brandon@ifup.org>
To: George Nychis <gnychis@cmu.edu>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Jeff Chua <jchua@fedex.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: suspend/hibernate to work on thinkpad x60s?
Message-ID: <20060719202333.GA8705@plankton.ifup.org>
References: <30DF6C25102A6E4BBD30B26C4EA1DCCC0162E099@MEMEXCH10V.corp.ds.fedex.com> <200607191742.32609.rjw@sisk.pl> <44BE5589.4070403@cmu.edu> <200607192102.17438.rjw@sisk.pl> <44BE8D7C.8070107@cmu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44BE8D7C.8070107@cmu.edu>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15:52 Wed 19 Jul 2006, George Nychis wrote:
> I see, so I guess I still have a disk problem after any type of suspend,
> has anyone gotten it to fully work with AHCI? any more suggestions?
> 
> I greatly appreciate all the help.

Hey George-

As was said earlier Forrest Zhao has created patches against 2.6.18-rc1
and posted[1] them to the linux-ide mailing list.  These patches restore
AHCI drives properly after a suspend.

	Brandon

[1] http://marc.theaimsgroup.com/?l=linux-ide&m=115277002327654&w=2

