Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266473AbUIOOQU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266473AbUIOOQU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 10:16:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266357AbUIOOP5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 10:15:57 -0400
Received: from convulsion.choralone.org ([212.13.208.157]:1800 "EHLO
	convulsion.choralone.org") by vger.kernel.org with ESMTP
	id S266223AbUIOOPP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 10:15:15 -0400
Date: Wed, 15 Sep 2004 15:14:55 +0100
From: Dave Jones <davej@redhat.com>
To: Joe Korty <joe.korty@ccur.com>
Cc: Arjan van de Ven <arjanv@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] tune vmalloc size
Message-ID: <20040915141455.GA24892@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Joe Korty <joe.korty@ccur.com>,
	Arjan van de Ven <arjanv@redhat.com>, Ingo Molnar <mingo@elte.hu>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040915125356.GA11250@elte.hu> <20040915132936.GB30233@tsunami.ccur.com> <20040915133144.GB30530@devserv.devel.redhat.com> <20040915134047.GA30493@tsunami.ccur.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040915134047.GA30493@tsunami.ccur.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2004 at 09:40:47AM -0400, Joe Korty wrote:

 > > boot time settable is 100x better than only compile time settable imo :)
 > 
 > IMO, everything that is changable at boot time needs an equivalent way
 > of changing the default without specifying a boot time value.
 > 
 > boot time values works well only when the number of values that need
 > changing is small.

Most users will never need to change this /at all/, at boot time,
or compile time. Its a corner case for certain hardware configurations.
That fits into 'small number of values' afaics.

		Dave

