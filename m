Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262129AbUJZEqT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262129AbUJZEqT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 00:46:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262122AbUJZEpZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 00:45:25 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:32959 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262129AbUJZElM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 00:41:12 -0400
Subject: Re: [PATCH] remove dead tcp exports
From: Lee Revell <rlrevell@joe-job.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: Werner Almesberger <wa@almesberger.net>, hch@lst.de, davem@redhat.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20041025204147.667ee2b1.davem@davemloft.net>
References: <20041024134309.GB20267@lst.de>
	 <20041026000710.D3841@almesberger.net>
	 <20041025204147.667ee2b1.davem@davemloft.net>
Content-Type: text/plain
Date: Tue, 26 Oct 2004 00:41:05 -0400
Message-Id: <1098765665.9404.5.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-10-25 at 20:41 -0700, David S. Miller wrote:
> On Tue, 26 Oct 2004 00:07:10 -0300
> Werner Almesberger <wa@almesberger.net> wrote:
> 
> > Wheee, you had me scared for a moment. But indeed, not even tcpcp
> > (tcpcp.sf.net) uses any of these. But I kind of wonder how you
> > determine they're "dead" ?
> 
> There are scripts which build everything as possible as modules
> then greps the symbol tables of the object files to see which
> symbols exported by the kernel are actually used.

Is this really a compelling reason to remove them?  For example ALSA
provides an API for driver writers, just because a certain function
happens not to be used by any does not mean is never will be or that it
should not.

Lee

