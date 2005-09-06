Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932402AbVIFEzu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932402AbVIFEzu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 00:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932400AbVIFEzt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 00:55:49 -0400
Received: from smtp.istop.com ([66.11.167.126]:45545 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S932394AbVIFEzt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 00:55:49 -0400
From: Daniel Phillips <phillips@istop.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: GFS, what's remainingh
Date: Tue, 6 Sep 2005 00:58:44 -0400
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org, Lars Marowsky-Bree <lmb@suse.de>,
       Andi Kleen <ak@suse.de>, linux clustering <linux-cluster@redhat.com>,
       akpm@osdl.org, linux-fsdevel@vger.kernel.org
References: <20050901104620.GA22482@redhat.com> <200509060002.40823.phillips@istop.com> <200509052307.27417.dtor_core@ameritech.net>
In-Reply-To: <200509052307.27417.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509060058.44934.phillips@istop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 06 September 2005 00:07, Dmitry Torokhov wrote:
> On Monday 05 September 2005 23:02, Daniel Phillips wrote:
> > By the way, you said "alpha server" not "alpha servers", was that just a
> > slip? Because if you don't have a cluster then why are you using a dlm?
>
> No, it is not a slip. The application is running on just one node, so we
> do not really use "distributed" part. However we make heavy use of the
> rest of lock manager features, especially lock value blocks.

Urk, so you imprinted on the clunkiest, most pathetically limited dlm feature 
without even having the excuse you were forced to use it.  Why don't you just 
have a daemon that sends your values over a socket?  That should be all of a 
day's coding.

Anyway, thanks for sticking your head up, and sorry if it sounds aggressive. 
But you nicely supported my claim that most who think they should be using a 
dlm, really shouldn't.

Regards,

Daniel
