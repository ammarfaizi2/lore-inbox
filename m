Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964854AbWBUVrP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964854AbWBUVrP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 16:47:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932794AbWBUVrP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 16:47:15 -0500
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:21951
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S932199AbWBUVrN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 16:47:13 -0500
Subject: Re: make -j with j <= 4 seems to only load a single CPU core
From: Paul Fulghum <paulkf@microgate.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Sam Ravnborg <sam@ravnborg.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <1140558161.9838.8.camel@amdx2.microgate.com>
References: <9a8748490602211302j61c0088fp8b555860e928028e@mail.gmail.com>
	 <9a8748490602211310j344db10evd685149a3c60b1e7@mail.gmail.com>
	 <1140558161.9838.8.camel@amdx2.microgate.com>
Content-Type: text/plain
Date: Tue, 21 Feb 2006 15:47:04 -0600
Message-Id: <1140558424.9838.10.camel@amdx2.microgate.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-02-21 at 15:42 -0600, Paul Fulghum wrote:
> I'm pretty sure with an earlier 2.6 kernel source (but same environment)
> I did not see this. I'll start back tracking to earlier kernels
> to see if I can identify when this started.

2.6.14 and 2.6.15 keeps both cores busy with -j 2
2.6.16 series appears to build serially with -j 2

-- 
Paul Fulghum
Microgate Systems, Ltd

