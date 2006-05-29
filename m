Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750705AbWE2MYa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750705AbWE2MYa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 08:24:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750734AbWE2MYa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 08:24:30 -0400
Received: from canuck.infradead.org ([205.233.218.70]:53166 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S1750705AbWE2MY3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 08:24:29 -0400
Subject: Re: Ethernet driver module compilation  (8139too)
From: David Woodhouse <dwmw2@infradead.org>
To: Chava Leviatan <chavale@actcom.net.il>
Cc: bidulock@openss7.org, linux-kernel@vger.kernel.org
In-Reply-To: <027e01c68313$e8e11440$c400a8c0@Chavalaptop>
References: <003101c682ff$1b7c7350$c400a8c0@Chavalaptop>
	 <20060529021315.B23539@openss7.org>
	 <023201c6830a$827539b0$c400a8c0@Chavalaptop>
	 <20060529035344.A25913@openss7.org>
	 <027e01c68313$e8e11440$c400a8c0@Chavalaptop>
Content-Type: text/plain
Date: Mon, 29 May 2006 13:24:17 +0100
Message-Id: <1148905457.11358.0.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-05-29 at 13:34 +0200, Chava Leviatan wrote:
> Thanks alot ! This exactly the line I was missing at my makefile !
> Now it works ... 

That should be done by the kernel makefile. Your real problem seems to
be that you were attempting to use your own makefile instead of the
kernel's.

-- 
dwmw2

