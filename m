Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264364AbUAMQTM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 11:19:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264368AbUAMQTM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 11:19:12 -0500
Received: from pentafluge.infradead.org ([213.86.99.235]:20203 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S264364AbUAMQTL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 11:19:11 -0500
Subject: Re: a symbol defined twice is ok?
From: David Woodhouse <dwmw2@infradead.org>
To: Samium Gromoff <deepfire@sic-elvis.zel.ru>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <87fzejua2e.wl@canopus.ns.zel.ru>
References: <87fzejua2e.wl@canopus.ns.zel.ru>
Content-Type: text/plain
Message-Id: <1074010747.17620.88.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8.dwmw2.2) 
Date: Tue, 13 Jan 2004 16:19:08 +0000
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-01-13 at 18:45 +0300, Samium Gromoff wrote:
> this is 2.4.20`s System.map:
> 
> deepfire@canopus:~$ cat kernel/k/System.map | cut -f3 -d\ | sort | uniq -d | wc -l
> 33

It's fine -- they'll all be static symbols. 

-- 
dwmw2

