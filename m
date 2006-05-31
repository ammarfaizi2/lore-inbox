Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751582AbWEaDJE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751582AbWEaDJE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 23:09:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751594AbWEaDJD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 23:09:03 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:56024 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751582AbWEaDJC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 23:09:02 -0400
Subject: Re: 2.6.17-rc5-mm1
From: Steven Rostedt <rostedt@goodmis.org>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Ingo Molnar <mingo@elte.hu>, Arjan van de Ven <arjan@linux.intel.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
In-Reply-To: <6bffcb0e0605301649u2d3c48f5td9b7998168df8114@mail.gmail.com>
References: <20060530022925.8a67b613.akpm@osdl.org>
	 <6bffcb0e0605301155h3b472d79h65e8403e7fa0b214@mail.gmail.com>
	 <6bffcb0e0605301157o6b7c5f66q3c9f151cbb4537d5@mail.gmail.com>
	 <20060530194259.GB22742@elte.hu>
	 <6bffcb0e0605301457v9ba284bk75b8b6d14384489a@mail.gmail.com>
	 <20060530220931.GA32759@elte.hu>
	 <6bffcb0e0605301559y603a60bl685b7aca60069dfd@mail.gmail.com>
	 <20060530230512.GA6042@elte.hu> <20060530230620.GA6226@elte.hu>
	 <6bffcb0e0605301649u2d3c48f5td9b7998168df8114@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 30 May 2006 23:08:46 -0400
Message-Id: <1149044926.28264.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-31 at 01:49 +0200, Michal Piotrowski wrote:
> On 31/05/06, Ingo Molnar <mingo@elte.hu> wrote:
> >
> > * Ingo Molnar <mingo@elte.hu> wrote:
> >
> > > Could you try the patch below? This uses the ID string as the key.
> > > (the ID string seems to be based on static kernel strings most of the
> > > time, so this might as well work)
> >
> > that patch should be:
> >
> 
> Thanks, problem solved.

Had the same problem, and I can also confirm that that patch fixes it.

-- Steve


