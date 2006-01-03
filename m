Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750796AbWACJbh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750796AbWACJbh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 04:31:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750831AbWACJbh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 04:31:37 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:59346 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750796AbWACJbh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 04:31:37 -0500
Subject: Re: hangcheck: hangcheck value past margin!
From: Arjan van de Ven <arjan@infradead.org>
To: Mark v Wolher <trilight@ns666.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <43BA43E9.2090106@ns666.com>
References: <43BA43E9.2090106@ns666.com>
Content-Type: text/plain
Date: Tue, 03 Jan 2006 10:31:33 +0100
Message-Id: <1136280694.2942.19.camel@laptopd505.fenrus.org>
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

On Tue, 2006-01-03 at 10:29 +0100, Mark v Wolher wrote:
> Hiya guys,
> 
> 
> I'm getting the msg "hangcheck: hangcheck value past margin!" every few
> minutes in the logs. It started all of a sudden. The kernel is a vanilla
> 2.6.14.5 on a remote box.
> 
> What could this mean ?

it means you enabled the hangcheck timer watchdog, and it seems to think
the kernel is too busy or losing time ;)
Did you mean to enable that watchdog?

