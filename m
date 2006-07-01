Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751268AbWGASim@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268AbWGASim (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 14:38:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751277AbWGASim
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 14:38:42 -0400
Received: from mx.pathscale.com ([64.160.42.68]:57821 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751268AbWGASim (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 14:38:42 -0400
Subject: Re: [PATCH] Add memcpy_nc, a copy routine that tries to keep cache
	pressure down
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org, davem@davemloft.net
In-Reply-To: <1151742454.3195.10.camel@laptopd505.fenrus.org>
References: <c37555581c772bf5c94a.1151729772@eng-12.pathscale.com>
	 <1151742454.3195.10.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Date: Sat, 01 Jul 2006 11:38:43 -0700
Message-Id: <1151779123.2194.22.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-07-01 at 10:27 +0200, Arjan van de Ven wrote:

> can we give this a more descriptive name please? Say
> memcpy_cachebypass() or something?

Sure.  I figured there was no way to coax a better name out of people
short of posting a patch with a bad name :-)

	<b

