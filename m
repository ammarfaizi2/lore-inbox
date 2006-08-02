Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750752AbWHBKSd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750752AbWHBKSd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 06:18:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750754AbWHBKSd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 06:18:33 -0400
Received: from mx1.suse.de ([195.135.220.2]:42154 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750752AbWHBKSc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 06:18:32 -0400
From: Andi Kleen <ak@suse.de>
To: Fernando Luis =?iso-8859-15?q?V=E1zquez_Cao?= 
	<fernando@oss.ntt.co.jp>
Subject: Re: [PATCH] x86_64: Replace local_save_flags+local_irq_disable with local_irq_save.
Date: Wed, 2 Aug 2006 12:18:27 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <1154513480.3268.21.camel@localhost.localdomain>
In-Reply-To: <1154513480.3268.21.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200608021218.27875.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 August 2006 12:11, Fernando Luis Vázquez Cao wrote:
> The combination of "local_save_flags" and "local_irq_disable" seems to be
> equivalent to "local_irq_save" (see code snips below). Consequently, replace
> occurrences of local_save_flags+local_irq_disable with local_irq_save.

Added thanks

-Andi
