Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271298AbTHHNKv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 09:10:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271311AbTHHNKv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 09:10:51 -0400
Received: from relay.uni-heidelberg.de ([129.206.100.212]:62372 "EHLO
	relay.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id S271298AbTHHNKt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 09:10:49 -0400
From: Bernd Schubert <bernd-schubert@web.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [2.4.21]: nbd ksymoops-report
Date: Fri, 8 Aug 2003 15:10:47 +0200
User-Agent: KMail/1.5.3
References: <Pine.LNX.4.10.10308071245130.13289-100000@clements.sc.steeleye.com> <3F328DB9.4EF38D9A@SteelEye.com> <3F32D1CD.CF8469A5@SteelEye.com>
In-Reply-To: <3F32D1CD.CF8469A5@SteelEye.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200308081510.47804.bernd-schubert@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 08 August 2003 00:25, you wrote:
> Paul Clements wrote:
> > Paul Clements wrote:
> > > On Thu, 7 Aug 2003, Bernd Schubert wrote:
> > > > every time when nbd-client disconnects a nbd-device the decoded oops
> > > > from below will happen.
> > > > This only happens after we upgraded from 2.4.20 to 2.4.21,
> > > > so I guess the backported update from 2.5.50 causes this.
>
> [snip]
>
> > > Would you be willing to test a patch against 2.4.21?
> >
> > If you're willing to test the attached patch, I'd be grateful. Otherwise
> > I'll test it in the next few days and forward on to Marcelo...
>
> OK, the previous patch didn't quite do it. The attached should work (I
> got a chance to test it, finally).

Hello Paul,

I just tested the patch and now 'nbd-client -d device' it works fine! When I'm 
back at work I will update our nbd-clients to the new module. (Now that you 
told me that 'kill -9 pid' even for the old module works, that won't be a 
problem.


Thanks a lot,
	Bernd
