Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264358AbTCXS7x>; Mon, 24 Mar 2003 13:59:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264365AbTCXS7x>; Mon, 24 Mar 2003 13:59:53 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:14342 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S264358AbTCXS7w>; Mon, 24 Mar 2003 13:59:52 -0500
Date: Mon, 24 Mar 2003 19:10:57 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andries.Brouwer@cwi.nl
Cc: akpm@digeo.com, linux-kernel@vger.kernel.org, zippel@linux-m68k.org
Subject: Re: [PATCH 1/3] revert register_chrdev_region change
Message-ID: <20030324191057.B23239@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andries.Brouwer@cwi.nl, akpm@digeo.com,
	linux-kernel@vger.kernel.org, zippel@linux-m68k.org
References: <UTC200303241907.h2OJ75619479.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <UTC200303241907.h2OJ75619479.aeb@smtp.cwi.nl>; from Andries.Brouwer@cwi.nl on Mon, Mar 24, 2003 at 08:07:05PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 24, 2003 at 08:07:05PM +0100, Andries.Brouwer@cwi.nl wrote:
> Yes, it is more elegant to register one or more ranges.
> (But ranges of what? Ranges in dev_t space? Or in kdev_t space?

In dev_t space.

> Here you see one reason to wait a little until dev_t/kdev_t
> stuff has settled.)

I guess basically everyone will disagree with you on making kdev_t
a different representation.  This will end up as messy as the
internal/external dev_t stuff on some of the SVR4 ports.

