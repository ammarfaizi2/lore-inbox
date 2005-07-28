Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261739AbVG1RHU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261739AbVG1RHU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 13:07:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261757AbVG1RHN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 13:07:13 -0400
Received: from graphe.net ([209.204.138.32]:6851 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S261739AbVG1RFa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 13:05:30 -0400
Date: Thu, 28 Jul 2005 10:05:28 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Adrian Bunk <bunk@stusta.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: RFC: Raise required gcc version to 3.2 ?
In-Reply-To: <20050728120012.GB3528@stusta.de>
Message-ID: <Pine.LNX.4.62.0507281003120.1262@graphe.net>
References: <20050728120012.GB3528@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Jul 2005, Adrian Bunk wrote:

> What is the oldest gcc we want to support in kernel 2.6?
> 
> Currently, it's 2.95 .
> 
> I'd suggest raising this to 3.2 which should AFAIK not be a problem for 
> any distribution supporting kernel 2.6 .

You have all my support for this. Some weird macros and code 
could be removed from the tree. F.e. One could use [] instead of [0] and 
there is a baaad macro in include/linux/mmzone.h in need of some healing 
touches.

> Is there any good reason why we should not drop support for older 
> compilers?

Probably but we should drop support anyways.

