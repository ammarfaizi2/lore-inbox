Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754158AbWKGJqq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754158AbWKGJqq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 04:46:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754159AbWKGJqq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 04:46:46 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:33204 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1754158AbWKGJqp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 04:46:45 -0500
Message-ID: <45505602.4000607@pobox.com>
Date: Tue, 07 Nov 2006 04:46:42 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20061027)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org, akpm@osdl.org,
       Matthew Wilcox <matthew@wil.cx>
Subject: Re: [PATCH] pdc202xx_old: Fix name clashes with PA-RISC
References: <1162559886.12810.12.camel@localhost.localdomain>
In-Reply-To: <1162559886.12810.12.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> pdc_* functions are part of the global namespace for the PDC on PA-RISC
> systems and this means our choice of pdc_ causes collisions between the
> PDC globals and our static functions. Rename them to pdc202xx where they
> are for both 2024x and 2026x.
> 
> Signed-off-by: Alan Cox <alan@redhat.com>

applied


