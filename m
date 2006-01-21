Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932193AbWAUORK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932193AbWAUORK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 09:17:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932196AbWAUORK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 09:17:10 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:2777 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932193AbWAUORJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 09:17:09 -0500
Subject: Re: [rfc] split_page function to split higher order pages?
From: Arjan van de Ven <arjan@infradead.org>
To: Nick Piggin <npiggin@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management List <linux-mm@kvack.org>
In-Reply-To: <20060121124053.GA911@wotan.suse.de>
References: <20060121124053.GA911@wotan.suse.de>
Content-Type: text/plain
Date: Sat, 21 Jan 2006 15:17:04 +0100
Message-Id: <1137853024.23974.0.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-01-21 at 13:40 +0100, Nick Piggin wrote:
> Hi,
> 
> Just wondering what people think of the idea of using a helper
> function to split higher order pages instead of doing it manually?

Maybe it's worth documenting that this is for kernel (or even
architecture) internal use only and that drivers really shouldn't be
doing this..

