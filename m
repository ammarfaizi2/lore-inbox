Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758542AbWK3H0L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758542AbWK3H0L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 02:26:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758541AbWK3H0L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 02:26:11 -0500
Received: from ns1.suse.de ([195.135.220.2]:49823 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1758533AbWK3H0J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 02:26:09 -0500
Date: Thu, 30 Nov 2006 08:26:08 +0100
From: Nick Piggin <npiggin@suse.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, linux-fsdevel@vger.kernel.org
Subject: [patch 0/3] more buffered write fixes
Message-ID: <20061130072608.GD18004@wotan.suse.de>
References: <20061130072058.GA18004@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061130072058.GA18004@wotan.suse.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, I should give some background.

The following patches attempt to fix the problems people have identified
with buffered write deadlock patches. Against 2.6.19 + the previous patchset
dropped from -mm.

Comments?

