Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261236AbUCPSdS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 13:33:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261368AbUCPSdS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 13:33:18 -0500
Received: from fmr05.intel.com ([134.134.136.6]:64203 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S261236AbUCPSdN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 13:33:13 -0500
From: Mark Gross <mgross@linux.co.intel.com>
Organization: Intel
To: Jamie Lokier <jamie@shareable.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: finding out the value of HZ from userspace
Date: Tue, 16 Mar 2004 10:16:02 -0800
User-Agent: KMail/1.5.4
Cc: lkml <linux-kernel@vger.kernel.org>
References: <20040311141703.GE3053@luna.mooo.com> <200403140245.i2E2jKSx005375@eeyore.valparaiso.cl> <20040315081713.GB7188@mail.shareable.org>
In-Reply-To: <20040315081713.GB7188@mail.shareable.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403161016.02568.mgross@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 15 March 2004 00:17, Jamie Lokier wrote:
> Horst von Brand wrote:
> > What for? It should be invisible to userspace...
>
> It's not invisible.  select/poll/epoll/setitimer round their time
> argument according to HZ, and programs which do smooth (i.e. low
> _jitter_) animation of the kind where the eye is sensitive to the
> jitter need to track it and correct for it.
>

Wouldn't it be better to just use high res timers and associated posix interfaces or low jitter applications?

--mgross

