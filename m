Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161020AbWARV5K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161020AbWARV5K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 16:57:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161025AbWARV5J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 16:57:09 -0500
Received: from mx1.redhat.com ([66.187.233.31]:9906 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161020AbWARV5I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 16:57:08 -0500
Date: Wed, 18 Jan 2006 16:56:55 -0500
From: Dave Jones <davej@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: reuben-lkml@reub.net, linux-kernel@vger.kernel.org, mingo@elte.hu,
       arjan@infradead.org
Subject: Re: 2.6.16-rc1-mm1
Message-ID: <20060118215655.GE5278@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>, reuben-lkml@reub.net,
	linux-kernel@vger.kernel.org, mingo@elte.hu, arjan@infradead.org
References: <20060118005053.118f1abc.akpm@osdl.org> <43CE2210.60509@reub.net> <20060118032716.7f0d9b6a.akpm@osdl.org> <20060118190926.GB316@redhat.com> <20060118134054.6c0db90a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060118134054.6c0db90a.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2006 at 01:40:54PM -0800, Andrew Morton wrote:
 > Dave Jones <davej@redhat.com> wrote:
 > >
 > > With the patch above we'll mutex_unlock twice.
 > 
 > I was just testing you.
 > 
 > >  Is that allowed ? It sounds wrong to me.
 > 
 > It worked!

Heh. Thanks, pushed out to cpufreq.git

		Dave
