Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751385AbWCaPCj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751385AbWCaPCj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 10:02:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751383AbWCaPCj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 10:02:39 -0500
Received: from cantor2.suse.de ([195.135.220.15]:56477 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751385AbWCaPCi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 10:02:38 -0500
From: Andi Kleen <ak@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [-mm patch] arch/i386/kernel/apic.c: make modern_apic() static
Date: Fri, 31 Mar 2006 17:02:19 +0200
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, mingo@elte.hu
References: <20060328003508.2b79c050.akpm@osdl.org> <20060331145648.GG3893@stusta.de>
In-Reply-To: <20060331145648.GG3893@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603311702.19669.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 31 March 2006 16:56, Adrian Bunk wrote:
> This patch makes a nnedlessly global function static.

Disagree. It will be likely used in more code in the future.

-Andi
