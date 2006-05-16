Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751880AbWEPTIG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751880AbWEPTIG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 15:08:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932435AbWEPTIG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 15:08:06 -0400
Received: from ns.suse.de ([195.135.220.2]:14523 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932429AbWEPTIF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 15:08:05 -0400
From: Andi Kleen <ak@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [-mm patch] arch/i386/oprofile/: make functions static
Date: Tue, 16 May 2006 21:07:57 +0200
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, dzickus <dzickus@redhat.com>,
       linux-kernel@vger.kernel.org
References: <20060515005637.00b54560.akpm@osdl.org> <20060516132405.GU6931@stusta.de>
In-Reply-To: <20060516132405.GU6931@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605162107.57507.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 16 May 2006 15:24, Adrian Bunk wrote:
> On Mon, May 15, 2006 at 12:56:37AM -0700, Andrew Morton wrote:
> >...
> > Changes since 2.6.17-rc3-mm1:
> >...
> > +x86_64-mm-remove-un-set_nmi_callback-and-reserve-release_lapic_nmi-functions.patch
> >...
> >  x86_64 tree updates
> >...
> 
> 
> This patch makes the following needlessly global functions static:
> - nmi_int.c: profile_exceptions_notify()
> - nmi_timer_int.c: profile_timer_exceptions_notify()

Applied.

-Andi
