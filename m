Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267351AbTACAh2>; Thu, 2 Jan 2003 19:37:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267352AbTACAh2>; Thu, 2 Jan 2003 19:37:28 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:36626 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267351AbTACAh1>; Thu, 2 Jan 2003 19:37:27 -0500
Date: Fri, 3 Jan 2003 00:45:57 +0000
From: Christoph Hellwig <hch@infradead.org>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: __NR_exit_group for 2.4-O(1)
Message-ID: <20030103004557.A10881@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"J.A. Magallon" <jamagallon@able.es>,
	Lista Linux-Kernel <linux-kernel@vger.kernel.org>
References: <20030103001522.GA1539@werewolf.able.es> <20030103003244.A10586@infradead.org> <20030103003617.GC1539@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030103003617.GC1539@werewolf.able.es>; from jamagallon@able.es on Fri, Jan 03, 2003 at 01:36:17AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 03, 2003 at 01:36:17AM +0100, J.A. Magallon wrote:
> > Your libc isn't the one from RH's new beta, is it? :)
> > 
> 
> Nope, Mandrake Cooker glibc-2.3.1-6.

glibc only tries to use sys_exit_group if the kernel headers it's compiled
against define __NR_exit_group.  AFAIK only the current RH beta ships
a kernel with a 2.4 backport of all the threading changes during 2.5, so
it might be worth asking the mdk glibc maintainer we he got his kernel
headers from.. (either redhat or 2.5 :))

