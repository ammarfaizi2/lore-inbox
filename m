Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932270AbWBUOcz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932270AbWBUOcz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 09:32:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932284AbWBUOcz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 09:32:55 -0500
Received: from [81.2.110.250] ([81.2.110.250]:38081 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S932270AbWBUOcz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 09:32:55 -0500
Subject: Re: [2.6 patch] unexport install_page
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: Hugh Dickins <hugh@veritas.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060221141341.GW4661@stusta.de>
References: <20060220223709.GT4661@stusta.de>
	 <20060221103808.GB19349@infradead.org>
	 <Pine.LNX.4.61.0602211227450.8400@goblin.wat.veritas.com>
	 <20060221141341.GW4661@stusta.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 21 Feb 2006 14:34:33 +0000
Message-Id: <1140532473.840.23.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2006-02-21 at 15:13 +0100, Adrian Bunk wrote:
> This means it has only bloated the kernel for two and a half years 
> for nearly everyone.

Wouldn't it be more productive to just shave 30 bytes off some other
function and make it faster instead of moaning about every single export
symbol that is provided even when its intentionally part of a complete
API ?


