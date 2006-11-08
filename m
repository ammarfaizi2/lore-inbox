Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422775AbWKHUDi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422775AbWKHUDi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 15:03:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422770AbWKHUDi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 15:03:38 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:11147 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1422775AbWKHUDh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 15:03:37 -0500
Subject: Re: 2.6.19-rc5: known regressions
From: Arjan van de Ven <arjan@infradead.org>
To: Jens Axboe <jens.axboe@oracle.com>
Cc: Alex Romosan <romosan@sycorax.lbl.gov>, linux-kernel@vger.kernel.org
In-Reply-To: <20061108192924.GA4527@kernel.dk>
References: <Pine.LNX.4.64.0611071829340.3667@g5.osdl.org>
	 <20061108085235.GT4729@stusta.de> <20061108093442.GB19471@kernel.dk>
	 <87ejsd3gcr.fsf@sycorax.lbl.gov>  <20061108192924.GA4527@kernel.dk>
Content-Type: text/plain
Organization: Intel International BV
Date: Wed, 08 Nov 2006 21:03:30 +0100
Message-Id: <1163016210.3138.382.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Wonderful! So this is an INQUIRY command, yet the WRITE bit is set. The
> drive gets really confused about that, for good reason. The question is
> where that write bit comes from, it looks really odd. Additionally, we

it could be a userspace command; some userspace tools send inquiry via
sg...


