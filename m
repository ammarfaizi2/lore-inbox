Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263165AbTCLMnF>; Wed, 12 Mar 2003 07:43:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263166AbTCLMnF>; Wed, 12 Mar 2003 07:43:05 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:2055 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S263165AbTCLMnE>; Wed, 12 Mar 2003 07:43:04 -0500
Date: Wed, 12 Mar 2003 12:53:10 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Torsten Foertsch <torsten.foertsch@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.4.19] How to get the path name of a struct dentry
Message-ID: <20030312125310.A10951@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Torsten Foertsch <torsten.foertsch@gmx.net>,
	linux-kernel@vger.kernel.org
References: <200303121033.08560.torsten.foertsch@gmx.net> <200303121138.31387.torsten.foertsch@gmx.net> <20030312104741.A9625@infradead.org> <200303121338.46661.torsten.foertsch@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200303121338.46661.torsten.foertsch@gmx.net>; from torsten.foertsch@gmx.net on Wed, Mar 12, 2003 at 01:38:42PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 12, 2003 at 01:38:42PM +0100, Torsten Foertsch wrote:
> > No.  Esecially as there is not single "real" root.
> 
> That means one can build a system with 2 (or more) completely independent file 
> system areas combining chroot() and pivot_root(), doesn't it?

I'm talking about namesapce.  Clone a new process with CLONE_NEWNS and all
modifications to the namespace are private to this process and it's children.

This way you can have e.g. process-private mounts.

