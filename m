Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262489AbREULme>; Mon, 21 May 2001 07:42:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262493AbREULmY>; Mon, 21 May 2001 07:42:24 -0400
Received: from ns.suse.de ([213.95.15.193]:22291 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S262489AbREULmT>;
	Mon, 21 May 2001 07:42:19 -0400
Date: Mon, 21 May 2001 13:41:32 +0200
From: Andi Kleen <ak@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: Andi Kleen <ak@suse.de>, Andrea Arcangeli <andrea@suse.de>,
        Andrew Morton <andrewm@uow.edu.au>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Richard Henderson <rth@twiddle.net>, linux-kernel@vger.kernel.org
Subject: Re: alpha iommu fixes
Message-ID: <20010521134132.C4545@gruyere.muc.suse.de>
In-Reply-To: <20010521112357.A1718@gruyere.muc.suse.de> <15112.57377.723591.710628@pizda.ninka.net> <20010521114216.A1968@gruyere.muc.suse.de> <15112.59192.613218.796909@pizda.ninka.net> <20010521122753.A2507@gruyere.muc.suse.de> <15112.61258.251051.960811@pizda.ninka.net> <20010521124225.A3417@gruyere.muc.suse.de> <15112.62483.731973.549006@pizda.ninka.net> <20010521130835.A3910@gruyere.muc.suse.de> <15112.64978.954038.894838@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15112.64978.954038.894838@pizda.ninka.net>; from davem@redhat.com on Mon, May 21, 2001 at 04:36:50AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2001 at 04:36:50AM -0700, David S. Miller wrote:
> I'd rather live with the hackish stuff temporarily, and get this all
> cleaned up in one shot when we have a real DAC support API.

Real would just be variants of the pci_* functions that currently take void * 
replaced with struct page *, or do you have something more fancy in mind?

-Andi
