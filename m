Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261943AbUEVWqO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261943AbUEVWqO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 18:46:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261976AbUEVWqN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 18:46:13 -0400
Received: from host213-160-108-25.dsl.vispa.com ([213.160.108.25]:35482 "HELO
	cenedra.office") by vger.kernel.org with SMTP id S261943AbUEVWqN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 18:46:13 -0400
From: Andrew Walrond <andrew@walrond.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [OT] Linux stability despite unstable hardware
Date: Sat, 22 May 2004 23:46:08 +0100
User-Agent: KMail/1.6
Cc: Timothy Miller <miller@techsource.com>
References: <40AE4493.3090202@techsource.com>
In-Reply-To: <40AE4493.3090202@techsource.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405222346.09208.andrew@walrond.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 21 May 2004 19:04, Timothy Miller wrote:
>
> But until the memory errors were fixed, things like KDE wouldn't build
> without gcc crashing.
>
> So, what is it about Linux that makes it build properly with a broken
> GCC and run perfectly despite memory errors?
>

The linux kernel is all c and assembler, and probably doesn't use too much mem 
during build. Kde on the other hand is all c++ and rather huge. It will 
likely use every bit of ram you have during the build, greatly increasing the 
chances of the memory error hitting you.

But.... Recompile your kernel with the good ram, just in case...
