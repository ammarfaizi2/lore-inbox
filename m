Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264592AbTFKWlW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 18:41:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264590AbTFKWk3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 18:40:29 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:30088 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S264582AbTFKWkU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 18:40:20 -0400
Date: Wed, 11 Jun 2003 23:53:50 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Toplica Tanaskovi?? <toptan@sezampro.yu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Via KT400 and AGP 8x Support
Message-ID: <20030611225350.GA522@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Toplica Tanaskovi?? <toptan@sezampro.yu>,
	linux-kernel@vger.kernel.org
References: <20030611212654.61150.qmail@web11307.mail.yahoo.com> <200306120036.21691.toptan@sezampro.yu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200306120036.21691.toptan@sezampro.yu>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 12, 2003 at 12:36:21AM +0200, Toplica Tanaskovi?? wrote:
 > Dana sreda 11. jun 2003. 23:26, Alex Deucher je napisao/la:
 > > Although I don't know that anyone has actually tried it in 8x mode.
 > > does anyone know if the radeon driver even has an AGPMode "8x" option?
 > > I haven't looked myself...
 > 
 > 	Nope, 4x max.

That's likely an X limitation. Someone with X-fu needs to hack that up
so it passes the right things through to agpgart. Would be nice to have
that in place for the next X release, so that when distros come to start
shipping 2.6, userspace is up to speed.

		Dave

