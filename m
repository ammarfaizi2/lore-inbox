Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265061AbTL1K6K (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Dec 2003 05:58:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265062AbTL1K6K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Dec 2003 05:58:10 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:33543 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265061AbTL1K6I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Dec 2003 05:58:08 -0500
Date: Sun, 28 Dec 2003 10:58:07 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.0-mm1
Message-ID: <20031228105807.A19546@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
References: <20031222211131.70a963fb.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20031222211131.70a963fb.akpm@osdl.org>; from akpm@osdl.org on Mon, Dec 22, 2003 at 09:11:31PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 22, 2003 at 09:11:31PM -0800, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test11/2.6.0-mm1/
> 
> 
> Quite a lot of new material here.  It would be appreciated if people who have
> significant patches in -mm could retest please.

BTW, could you please drop Al's RD* patches?  They change the entry points
for block drivers and thus create some hassle for people hacking on out
of tree block drivers, and obviously can't go into mainline as is.

