Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262234AbVHAQPC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262234AbVHAQPC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 12:15:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262169AbVHAQMs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 12:12:48 -0400
Received: from graphe.net ([209.204.138.32]:14992 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S262111AbVHAQKS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 12:10:18 -0400
Date: Mon, 1 Aug 2005 09:10:12 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Richard Purdie <rpurdie@rpsys.net>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc3-mm3
In-Reply-To: <1122860603.7626.32.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.62.0508010908530.3546@graphe.net>
References: <20050728025840.0596b9cb.akpm@osdl.org>
 <1122860603.7626.32.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Aug 2005, Richard Purdie wrote:

> The system appears to be ok and boots happily to a console but if you
> load any graphical UI, the screen will blank and the process stops
> working (tested with opie and and xserver+GPE). You can kill -9 the
> process but you can't regain the console without a suspend/resume cycle
> which performs enough of a reset to get it back. chvt and the console
> switching keys don't respond.

Is this related to the size of the process? Can you do a successful kernel 
compile w/o X?
 
> I tried the patch mentioned in http://lkml.org/lkml/2005/7/28/304 but it
> makes no difference.

Yes that only helps if compilation fails and its alread in rc4-mm1 AFAIK.

