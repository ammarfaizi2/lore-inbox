Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932241AbVHRPjd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932241AbVHRPjd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 11:39:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932258AbVHRPjc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 11:39:32 -0400
Received: from iona.labri.fr ([147.210.8.143]:55747 "EHLO iona.labri.fr")
	by vger.kernel.org with ESMTP id S932241AbVHRPjc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 11:39:32 -0400
Date: Thu, 18 Aug 2005 17:39:32 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: Re: idle task's task_t allocation on NUMA machines
Message-ID: <20050818153932.GH8123@implementation.labri.fr>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	Eric Dumazet <dada1@cosmosbay.com>, linux-kernel@vger.kernel.org,
	lse-tech@lists.sourceforge.net
References: <20050818140829.GB8123@implementation.labri.fr> <4304A6DF.6040703@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4304A6DF.6040703@cosmosbay.com>
User-Agent: Mutt/1.5.9i-nntp
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Dumazet, le Thu 18 Aug 2005 17:18:55 +0200, a écrit :
> An idle task should block itself, hence not touching its task_t structure 
> very much.

Indeed, but I guess there are a lot of such little optimizations here
and there that could be relatively easily fixed, for a not-so little
benefit.

> I believe IRQ stacks are also allocated on node 0, that seems more serious.

Such as this :)

Regards,
Samuel
