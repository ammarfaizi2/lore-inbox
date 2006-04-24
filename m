Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932122AbWDXXoV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932122AbWDXXoV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 19:44:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932119AbWDXXoV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 19:44:21 -0400
Received: from mx1.suse.de ([195.135.220.2]:24045 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932122AbWDXXoU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 19:44:20 -0400
From: Andi Kleen <ak@suse.de>
To: Jon Mason <jdmason@us.ibm.com>
Subject: Re: [PATCH] mm: add a nopanic option for low bootmem
Date: Tue, 25 Apr 2006 00:43:38 +0200
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org, mulix@mulix.org
References: <20060424214428.GA14575@us.ibm.com>
In-Reply-To: <20060424214428.GA14575@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604250043.38590.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 24 April 2006 23:44, Jon Mason wrote:
> This patch adds a no panic option for low bootmem allocs.  This will
> allow for a more graceful handling of "out of memory" for those
> callers who wish to handle it.

What's the user of it? Normally we don't merge such changes without
an user.

-Andi
