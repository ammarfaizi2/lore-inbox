Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261935AbUJZFrz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261935AbUJZFrz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 01:47:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261925AbUJZFp1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 01:45:27 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:18117 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261402AbUJZFoA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 01:44:00 -0400
Subject: Re: [PATCH] remove dead tcp exports
From: Lee Revell <rlrevell@joe-job.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: wa@almesberger.net, hch@lst.de, davem@redhat.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20041025215216.54b362f9.davem@davemloft.net>
References: <20041024134309.GB20267@lst.de>
	 <20041026000710.D3841@almesberger.net>
	 <20041025204147.667ee2b1.davem@davemloft.net>
	 <1098765665.9404.5.camel@krustophenia.net>
	 <20041025215216.54b362f9.davem@davemloft.net>
Content-Type: text/plain
Date: Tue, 26 Oct 2004 01:43:57 -0400
Message-Id: <1098769437.9404.10.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-10-25 at 21:52 -0700, David S. Miller wrote:
> On Tue, 26 Oct 2004 00:41:05 -0400
> Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > Is this really a compelling reason to remove them?  For example ALSA
> > provides an API for driver writers, just because a certain function
> > happens not to be used by any does not mean is never will be or that it
> > should not.
> 
> These are actually TCP internals, not a "well defined driver API"
> as ALSA defines.
> 

Yeah but there was also a patch posted that removed a bunch of "dead
exports" from ALSA.  I was wondering in general what the standard is for
distinguishing the two cases.

Lee

