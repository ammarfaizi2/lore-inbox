Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932303AbWCRJWF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932303AbWCRJWF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 04:22:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932338AbWCRJWE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 04:22:04 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:15823 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932335AbWCRJWD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 04:22:03 -0500
Subject: Re: Dual Core on Linux questions
From: Arjan van de Ven <arjan@infradead.org>
To: Alejandro Bonilla <abonilla@linuxwireless.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060318082434.M33432@linuxwireless.org>
References: <20060318082434.M33432@linuxwireless.org>
Content-Type: text/plain
Date: Sat, 18 Mar 2006 10:21:58 +0100
Message-Id: <1142673719.2889.9.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-03-18 at 02:35 -0600, Alejandro Bonilla wrote:
> Hi,
> 
> I have a few questions about the PM Dual Core and how could it really work
> with Linux. Sorry if there are new patches on LKML about any of these things:
> 
> Could each processor or die, have it's own cpufreq scaling governor?
> 
> Is there a way to allow one die to be idle and let the other one normal?
> 
> So in other words, could we manage these processors speedstep, utilization and
> workload individually?


afaik the cpuspeed daemon already supports this.
(not all dual core hardware can do this, but for the hw that can,
cpuspeed supports it)

