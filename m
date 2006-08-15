Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965025AbWHOMk5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965025AbWHOMk5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 08:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932779AbWHOMk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 08:40:57 -0400
Received: from alpha.polcom.net ([83.143.162.52]:24499 "EHLO alpha.polcom.net")
	by vger.kernel.org with ESMTP id S932776AbWHOMk4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 08:40:56 -0400
Date: Tue, 15 Aug 2006 14:40:48 +0200 (CEST)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Andrew Morton <akpm@osdl.org>
Cc: Andrzej Szymanski <szymans@agh.edu.pl>, linux-kernel@vger.kernel.org
Subject: Re: Strange write starvation on 2.6.17 (and other) kernels
In-Reply-To: <20060815005025.22e8adfe.akpm@osdl.org>
Message-ID: <Pine.LNX.4.63.0608151439080.8124@alpha.polcom.net>
References: <44E0A69C.5030103@agh.edu.pl> <20060815005025.22e8adfe.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Aug 2006, Andrew Morton wrote:
> Which filesystem?
>
> If ext3 in ordered-data mode: any fsync() will sync the whole filesystem
> (it has to).

Could you explain some more why it has to?... Is this caused by design of 
ext3 or any filesystem in ordered-data mode has to do it?


Thanks,

Grzegorz Kulewski

