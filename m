Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262019AbTEBMCu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 08:02:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262021AbTEBMCu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 08:02:50 -0400
Received: from mx01.arcor-online.net ([151.189.8.96]:62420 "EHLO mx01.nexgo.de")
	by vger.kernel.org with ESMTP id S262019AbTEBMCu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 08:02:50 -0400
From: Daniel Phillips <dphillips@sistina.com>
Reply-To: dphillips@sistina.com
Organization: Sistina
To: Andrew Morton <akpm@digeo.com>
Subject: Re: [RFC][PATCH] Faster generic_fls
Date: Fri, 2 May 2003 14:21:00 +0200
User-Agent: KMail/1.5.1
Cc: willy@w.ods.org, schlicht@uni-mannheim.de, hugang@soulinfo.com,
       linux-kernel@vger.kernel.org
References: <200304300446.24330.dphillips@sistina.com> <200305020243.15248.dphillips@sistina.com> <20030501175450.4afb1e48.akpm@digeo.com>
In-Reply-To: <20030501175450.4afb1e48.akpm@digeo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305021421.00381.dphillips@sistina.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 02 May 2003 02:54, Andrew Morton wrote:
> Would it be churlish to point out that the only significant user of fls()
> is sctp_v6_addr_match_len()?

Maybe.  It's also useful for breaking up an arbitrary IO region optimally into 
binary-sized blocks, which is part of the current 2.4 device-mapper patch 
set, not yet submitted.

Regards,

Daniel
