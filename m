Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261409AbVCUArr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261409AbVCUArr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 19:47:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261404AbVCUArr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 19:47:47 -0500
Received: from graphe.net ([209.204.138.32]:58886 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S261409AbVCUArl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 19:47:41 -0500
Date: Sun, 20 Mar 2005 16:47:33 -0800 (PST)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@server.graphe.net
To: Andrew Morton <akpm@osdl.org>
cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] del_timer_sync scalability patch
In-Reply-To: <20050320153446.32a9215a.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0503201641230.2021@server.graphe.net>
References: <200503202319.j2KNJXg29946@unix-os.sc.intel.com>
 <20050320153446.32a9215a.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Mar 2005, Andrew Morton wrote:

> "Chen, Kenneth W" <kenneth.w.chen@intel.com> wrote:
> >
> > We did exactly the same thing about 10 months back.  Nice to
> > see that independent people came up with exactly the same
> > solution that we proposed 10 months back.
>
> Well the same question applies.  Christoph, which code is calling
> del_timer_sync() so often that you noticed?

Ummm. I have to ask those who brought this to my attention. Are you
looking for the application under which del_timer_sync showed up in
profiling or the kernel subsystem?

