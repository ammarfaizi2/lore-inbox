Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264643AbUD1GGi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264643AbUD1GGi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 02:06:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264647AbUD1GGh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 02:06:37 -0400
Received: from prosun.first.gmd.de ([194.95.168.2]:24266 "EHLO
	prosun.first.fraunhofer.de") by vger.kernel.org with ESMTP
	id S264643AbUD1GGe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 02:06:34 -0400
To: linux-kernel@vger.kernel.org
Date: Wed, 28 Apr 2004 08:06:19 +0200
From: Soeren Sonnenburg <kernel@nn7.de>
Message-ID: <pan.2004.04.28.06.06.19.311999@nn7.de>
Organization: Local Intranet News
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
References: <1083047064.3158.2.camel@localhost>
Subject: Re: Largest mallocs opteron vs. 32bit systems
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Apr 2004 06:24:24 +0000, Soeren Sonnenburg wrote:

> Hello...
> 
> I just did some tests trying to malloc() memory on an opteron and a xeon
> system...
> [...]
> So one 'looses' 500M.
> 
> Feedback welcome,
> Soeren


I just want to mention, that this is kernel 2.4.21 (including quite a
number of redhat patches...) and due to a miscomputation 100M should be
added to every number...

Also when I malloc in smaller blocks (ie. size 1M) I get closer to 3G on a
i386 system (like 29xxM).

Soeren


