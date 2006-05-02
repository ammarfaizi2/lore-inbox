Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964834AbWEBOFM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964834AbWEBOFM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 10:05:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964835AbWEBOFL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 10:05:11 -0400
Received: from canuck.infradead.org ([205.233.218.70]:55743 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S964834AbWEBOFK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 10:05:10 -0400
Subject: Re: PATCH (RFC): Rework the 8250 console fix
From: David Woodhouse <dwmw2@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <1146578983.3519.49.camel@localhost.localdomain>
References: <1146578983.3519.49.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 02 May 2006 15:05:02 +0100
Message-Id: <1146578702.17934.3.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-05-02 at 15:09 +0100, Alan Cox wrote:
> There are two questions that I think make this an RFC not a final
> patch
> 
> 1.      Should this be pushed up into serial/serial_core.c for all chips. 

Yes, I think it probably should. It's icky enough that we want one copy
of it only.

-- 
dwmw2

