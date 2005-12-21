Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751159AbVLUSmI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751159AbVLUSmI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 13:42:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751162AbVLUSmH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 13:42:07 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:40905 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751159AbVLUSmG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 13:42:06 -0500
Subject: Re: [PATCH] handle module ref count on sysctl tables.
From: Arjan van de Ven <arjan@infradead.org>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Al Viro <viro@ftp.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
In-Reply-To: <20051221103520.258ced08@dxpl.pdx.osdl.net>
References: <20051221103520.258ced08@dxpl.pdx.osdl.net>
Content-Type: text/plain
Date: Wed, 21 Dec 2005 19:42:02 +0100
Message-Id: <1135190522.3456.72.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-12-21 at 10:35 -0800, Stephen Hemminger wrote:
> 
> This patch fixes that by maintaining source compatibility via macro.
> I am sure someone already thought of this, it just doesn't appear to
> have made it in yet.

isn't it more consistent to give the sysctl table itself an .owner
field?

