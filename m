Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932513AbWG0KMF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932513AbWG0KMF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 06:12:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932542AbWG0KMF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 06:12:05 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:36565 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932513AbWG0KME (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 06:12:04 -0400
Subject: Re: The ondemand CPUFreq code -- I hope the functionality stays
From: Arjan van de Ven <arjan@infradead.org>
To: Miles Lane <miles.lane@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <a44ae5cd0607270154p50c2c7fcx734bfea026dc69a9@mail.gmail.com>
References: <a44ae5cd0607270154p50c2c7fcx734bfea026dc69a9@mail.gmail.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Thu, 27 Jul 2006 12:12:01 +0200
Message-Id: <1153995121.3039.43.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-07-27 at 10:54 +0200, Miles Lane wrote:
> Hello,
> 
> It sounds, from comments in the discussion of CPU Hotplug locking
> problems, as though you are considering deleting the ondemand CPUFreq
> code. 

Hi,

I think you misunderstood; we are considering removing the cpu hotplug
locking (from cpufreq), not ondemand itself. ondemand itself is not a
problem in itself, it's only the hotplug locking that's an issue (and
that issue is bigger than just ondemand btw)

Greetings,
   Arjan van de Ven
-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com

