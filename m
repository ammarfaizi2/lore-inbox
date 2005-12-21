Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751179AbVLUSrk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751179AbVLUSrk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 13:47:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751178AbVLUSrk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 13:47:40 -0500
Received: from smtp.osdl.org ([65.172.181.4]:61403 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751166AbVLUSrj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 13:47:39 -0500
Date: Wed, 21 Dec 2005 10:47:14 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Al Viro <viro@ftp.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] handle module ref count on sysctl tables.
Message-ID: <20051221104714.51028ff2@dxpl.pdx.osdl.net>
In-Reply-To: <1135190522.3456.72.camel@laptopd505.fenrus.org>
References: <20051221103520.258ced08@dxpl.pdx.osdl.net>
	<1135190522.3456.72.camel@laptopd505.fenrus.org>
X-Mailer: Sylpheed-Claws 1.9.100 (GTK+ 2.6.10; x86_64-redhat-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Dec 2005 19:42:02 +0100
Arjan van de Ven <arjan@infradead.org> wrote:

> On Wed, 2005-12-21 at 10:35 -0800, Stephen Hemminger wrote:
> > 
> > This patch fixes that by maintaining source compatibility via macro.
> > I am sure someone already thought of this, it just doesn't appear to
> > have made it in yet.
> 
> isn't it more consistent to give the sysctl table itself an .owner
> field?

yes, but that means changing more files.

-- 
Stephen Hemminger <shemminger@osdl.org>
OSDL http://developer.osdl.org/~shemminger
