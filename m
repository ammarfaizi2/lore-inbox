Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261872AbVFGTl3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261872AbVFGTl3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 15:41:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261878AbVFGTl3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 15:41:29 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:37002 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261872AbVFGTl1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 15:41:27 -0400
Date: Tue, 7 Jun 2005 20:41:23 +0100
From: Christoph Hellwig <hch@infradead.org>
To: christoph <christoph@scalex86.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Move some more structures into "mostly_readonly"
Message-ID: <20050607194123.GA16637@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	christoph <christoph@scalex86.org>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.62.0506071128220.22950@ScMPusgw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0506071128220.22950@ScMPusgw>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2005 at 11:30:03AM -0700, christoph wrote:
> Move syscall table, timer_hpet and the boot_cpu_data into the "mostly_readonly" section.

the syscall table should be completely readonly.

