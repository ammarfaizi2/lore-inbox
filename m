Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750745AbWCYEBk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750745AbWCYEBk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 23:01:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750753AbWCYEBk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 23:01:40 -0500
Received: from mail06.syd.optusnet.com.au ([211.29.132.187]:48095 "EHLO
	mail06.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1750745AbWCYEBk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 23:01:40 -0500
From: Con Kolivas <kernel@kolivas.org>
To: "=?iso-8859-1?q?Andr=E9_Goddard?= Rosa" <andre.goddard@gmail.com>
Subject: Re: [ck] [benchmark] Interbench 2.6.16-ck/mm
Date: Sat, 25 Mar 2006 15:01:32 +1100
User-Agent: KMail/1.9.1
Cc: "linux list" <linux-kernel@vger.kernel.org>,
       "ck list" <ck@vds.kolivas.org>
References: <200603251351.57341.kernel@kolivas.org> <b8bf37780603241919x52e5711bpee734d3d9ec11cb9@mail.gmail.com>
In-Reply-To: <b8bf37780603241919x52e5711bpee734d3d9ec11cb9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200603251501.32592.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 25 March 2006 14:19, André Goddard Rosa wrote:
> On 3/24/06, Con Kolivas <kernel@kolivas.org> wrote:
> > Note that most of the differences between -ck and -mm on this benchmark
> > are due to the staircase cpu scheduler in -ck. It has staircase v14.2 as
> > recently posted to the mailing list.

> I just tried  2.6.16-mm1 with Mike Galbraith patches and it feels
> better in some situations (like opening a new tab inside konqueror or
> running a configure script ) but it gave some
> stops when playing amarok/gstreamer and doing regular desktop work.

Thanks.

I don't expect that staircase will be better in every single situation. 
However it will be better more often, especially when it counts (like audio 
or video skipping) and far more predictable. All that in 300 lines less 
code :)

Cheers,
Con
