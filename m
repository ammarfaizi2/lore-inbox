Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932991AbWF2WAa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932991AbWF2WAa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 18:00:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932968AbWF2WAS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 18:00:18 -0400
Received: from mx1.suse.de ([195.135.220.2]:28890 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932992AbWF2WAL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 18:00:11 -0400
From: Andi Kleen <ak@suse.de>
To: Jeff Dike <jdike@addtoit.com>
Subject: Re: [PATCH 3/9] UML - Remove pte_mkexec
Date: Thu, 29 Jun 2006 23:41:13 +0200
User-Agent: KMail/1.9.3
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
References: <200606292136.k5TLaTGc010802@ccure.user-mode-linux.org>
In-Reply-To: <200606292136.k5TLaTGc010802@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606292341.13952.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 29 June 2006 23:36, Jeff Dike wrote:
> Andi is making pte_mkexec go away, and UML had one of the last uses.

Actually not go away, but do the correct thing on i386/x86-64.
Just relying on its side effects of setting _USER was bad.

Thanks,
-Andi
