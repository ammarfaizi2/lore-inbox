Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261327AbUL2JIB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261327AbUL2JIB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 04:08:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261328AbUL2JIB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 04:08:01 -0500
Received: from gw.c9x.org ([213.41.131.17]:3937 "HELO nerim.mx.42-networks.com")
	by vger.kernel.org with SMTP id S261327AbUL2JH6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 04:07:58 -0500
Date: Wed, 29 Dec 2004 10:07:35 +0100
From: "Frank Denis \(Jedi/Sector One\)" <lkml@pureftpd.org>
To: linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at fs/namei.c:2333 (reiserfs related?)
Message-ID: <20041229090757.GA27378@c9x.org>
References: <20041227112349.GA29389@c9x.org> <20041228203105.57467469.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041228203105.57467469.akpm@osdl.org>
X-Operating-System: OpenBSD - http://www.openbsd.org/
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 28, 2004 at 08:31:05PM -0800, Andrew Morton wrote:
> >  kernel BUG at fs/namei.c:2333!
> Were filesystem quotas in use at the time?

  No, quota weren't in use.
  
  And Vlad's recent fixes for reiserfs were applied.
