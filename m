Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264725AbUFPUDN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264725AbUFPUDN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 16:03:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264728AbUFPUDN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 16:03:13 -0400
Received: from peabody.ximian.com ([130.57.169.10]:2755 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S264725AbUFPUDL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 16:03:11 -0400
Subject: Re: Programtically tell diff between HT and real
From: Robert Love <rml@ximian.com>
To: Phy Prabab <phyprabab@yahoo.com>
Cc: David van Hoose <david.vanhoose@comcast.net>, linux-kernel@vger.kernel.org
In-Reply-To: <20040616200102.93550.qmail@web51807.mail.yahoo.com>
References: <20040616200102.93550.qmail@web51807.mail.yahoo.com>
Content-Type: text/plain
Date: Wed, 16 Jun 2004 16:03:08 -0400
Message-Id: <1087416188.7869.5.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9.1 (1.5.9.1-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-06-16 at 13:01 -0700, Phy Prabab wrote:

> So, if I understand correctly, there is no way to know
> definitively if a cpu is HT or not?

I'd do both of the things I said: test for HT, and then look for another
processor with the same physical id but a different processor value.

	Robert Love


