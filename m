Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750755AbWD2Qni@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750755AbWD2Qni (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Apr 2006 12:43:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750759AbWD2Qni
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Apr 2006 12:43:38 -0400
Received: from mx1.redhat.com ([66.187.233.31]:40896 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750755AbWD2Qnh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Apr 2006 12:43:37 -0400
Date: Sat, 29 Apr 2006 12:43:31 -0400
From: Dave Jones <davej@redhat.com>
To: devzero@web.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: another kconfig target for building monolithic kernel (for security) ?
Message-ID: <20060429164331.GA26122@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, devzero@web.de,
	linux-kernel@vger.kernel.org
References: <1093777985@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093777985@web.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 29, 2006 at 03:03:55PM +0200, devzero@web.de wrote:

 > i want to harden a linux system (dedicated root server on the internet) by recompiling the kernel without support for lkm (to prevent installation of lkm based rootkits etc)

Loading modules via /dev/kmem is trivial thanks to a bunch of tutorials and
examples on the web, so this alone doesn't make life that much more difficult for attackers.

		Dave

-- 
http://www.codemonkey.org.uk
