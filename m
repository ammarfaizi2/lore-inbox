Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030295AbWGMTFo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030295AbWGMTFo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 15:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030290AbWGMTFo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 15:05:44 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:61347 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030295AbWGMTFn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 15:05:43 -0400
Date: Thu, 13 Jul 2006 12:05:12 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Adrian Bunk <bunk@stusta.de>
cc: linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
       torvalds@osdl.org, akpm@osdl.org
Subject: Re: RFC: cleaning up the in-kernel headers
In-Reply-To: <20060711160639.GY13938@stusta.de>
Message-ID: <Pine.LNX.4.64.0607131201050.28976@schroedinger.engr.sgi.com>
References: <20060711160639.GY13938@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jul 2006, Adrian Bunk wrote:

> This would also remove all the implicit rules "before #include'ing 
> header foo.h, you must #include header bar.h" you usually only see when 
> the compilation fails.
> 
> There might be exceptions (e.g. for avoiding circular #include's) but 
> these would be special cases.

Great! Yes please. There is also some weirdness in #include in the 
middle of another .h file (see mm.h). It would be great if you could find 
a solution.
