Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265398AbUATLfR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 06:35:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265437AbUATLfR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 06:35:17 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:7941 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265398AbUATLfM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 06:35:12 -0500
Date: Tue, 20 Jan 2004 11:35:11 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.1-mm5
Message-ID: <20040120113511.A14742@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
References: <20040120000535.7fb8e683.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040120000535.7fb8e683.akpm@osdl.org>; from akpm@osdl.org on Tue, Jan 20, 2004 at 12:05:35AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(ghash.patch)

Please don't readd include/linux/ghash.h - it was removed because it's
utter crap.  Better switch UML to use some sane hashing.

Damn, I really hoped that beast would be dead.
