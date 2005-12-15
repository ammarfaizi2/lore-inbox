Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751199AbVLOXRO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199AbVLOXRO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 18:17:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751202AbVLOXRO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 18:17:14 -0500
Received: from mx1.redhat.com ([66.187.233.31]:27049 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751200AbVLOXRM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 18:17:12 -0500
Date: Thu, 15 Dec 2005 18:15:38 -0500
From: Dave Jones <davej@redhat.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       arjan@infradead.org
Subject: Re: [2.6 patch] i386: always use 4k stacks
Message-ID: <20051215231538.GF3419@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, arjan@infradead.org
References: <20051215212447.GR23349@stusta.de> <20051215140013.7d4ffd5b.akpm@osdl.org> <20051215223000.GU23349@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051215223000.GU23349@stusta.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2005 at 11:30:00PM +0100, Adrian Bunk wrote:

 > An how many weird crashes with _different_ causes have you seen?
 > It could be that there are only _very_ few problems that noone really 
 > debugs brcause disabling 4k stacks fixes the issue.

the block layer issue that Neil had patches for was the only one
that rings any bells for me[*] (and the only one in Fedora bugzilla
that anyone has actually hit -- and that's 2-3 people out of
a *lot* of users).

		Dave

[*] Plus a few XFS ones, but that's been a lost cause wrt stack usage
for a long time -- people were reporting overflows there before we
enabled 4K stacks.

