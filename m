Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261291AbSIZAVI>; Wed, 25 Sep 2002 20:21:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261393AbSIZAVI>; Wed, 25 Sep 2002 20:21:08 -0400
Received: from ns.commfireservices.com ([216.6.9.162]:13066 "HELO
	hemi.commfireservices.com") by vger.kernel.org with SMTP
	id <S261291AbSIZAVH>; Wed, 25 Sep 2002 20:21:07 -0400
Date: Wed, 25 Sep 2002 20:25:45 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Peter Chubb <peter@chubb.wattle.id.au>
Cc: Lightweight Patch Manager <patch@luckynet.dynu.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Tomas Szepe <szepe@pinerecords.com>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH][2.5] Single linked lists for Linux
In-Reply-To: <15762.20827.271317.595537@wombat.chubb.wattle.id.au>
Message-ID: <Pine.LNX.4.44.0209252024450.14916-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Sep 2002, Peter Chubb wrote:

> This only works if head->next == entry otherwise you lose half your
> list.  Also, none of this is SMP-safe.
> 
> I think you need something like this (but with locking!)

Should you really be having locking in a primitive like that? That 
shouldn't be taken care of at that level.

	Zwane
-- 
function.linuxpower.ca

