Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272796AbTHEQ0n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 12:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272837AbTHEQ0n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 12:26:43 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:44195 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S272796AbTHEQ0S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 12:26:18 -0400
Date: Tue, 5 Aug 2003 18:26:04 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Ducrot Bruno <poup@poupinou.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [TRIVIAL] sanitize power management config menus, take two
Message-ID: <20030805162604.GF18982@louise.pinerecords.com>
References: <20030805072631.GC5876@louise.pinerecords.com> <20030805161117.GA1511@poupinou.org> <20030805161505.GD18982@louise.pinerecords.com> <20030805162428.GB1511@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030805162428.GB1511@poupinou.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [poup@poupinou.org]
> 
> > o  only enable cpufreq options if power management is selected
> > o  don't put cpufreq options in a separate submenu
> 
> Yes, but what I do not understand is why cpufreq need power management.

Because it is a power management option. :)

CONFIG_PM is a dummy option, it does not link any code into the kernel
by itself.

-- 
Tomas Szepe <szepe@pinerecords.com>
