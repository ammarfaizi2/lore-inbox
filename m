Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266391AbUIONnf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266391AbUIONnf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 09:43:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266324AbUIONmF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 09:42:05 -0400
Received: from mx1.redhat.com ([66.187.233.31]:5803 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266357AbUIONkV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 09:40:21 -0400
Date: Wed, 15 Sep 2004 09:40:09 -0400
From: Dave Jones <davej@redhat.com>
To: Joe Korty <joe.korty@ccur.com>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] tune vmalloc size
Message-ID: <20040915134008.GA5810@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Joe Korty <joe.korty@ccur.com>, Ingo Molnar <mingo@elte.hu>,
	Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@redhat.com>,
	linux-kernel@vger.kernel.org
References: <20040915125356.GA11250@elte.hu> <20040915132936.GB30233@tsunami.ccur.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040915132936.GB30233@tsunami.ccur.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2004 at 09:29:36AM -0400, Joe Korty wrote:
 > On Wed, Sep 15, 2004 at 02:53:56PM +0200, Ingo Molnar wrote:
 > > 
 > > there are a few devices that use lots of ioremap space. vmalloc space is
 > > a showstopper problem for them.
 > > 
 > > this patch adds the vmalloc=<size> boot parameter to override
 > > __VMALLOC_RESERVE. The default is 128mb right now - e.g. vmalloc=256m
 > > doubles the size.
 > 
 > Perhaps this should instead be a configurable.

that would make it useless for distribution kernels for eg.

		Dave
