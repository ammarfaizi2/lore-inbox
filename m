Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964779AbWDZOPE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964779AbWDZOPE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 10:15:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932456AbWDZOPE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 10:15:04 -0400
Received: from cantor.suse.de ([195.135.220.2]:51131 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932455AbWDZOPC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 10:15:02 -0400
From: Andi Kleen <ak@suse.de>
To: "Jan Beulich" <jbeulich@novell.com>
Subject: Re: [PATCH] serialize assign_irq_vector() use of static variables
Date: Wed, 26 Apr 2006 16:14:17 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org
References: <444F9AD9.76E4.0078.0@novell.com>
In-Reply-To: <444F9AD9.76E4.0078.0@novell.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604261614.17592.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 26 April 2006 16:07, Jan Beulich wrote:
> Since assign_irq_vector() can be called at runtime, its access of static
> variables should be protected by a lock.

Applied thanks.

-Andi
