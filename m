Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261338AbVCFIKM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261338AbVCFIKM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 03:10:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261346AbVCFIKL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 03:10:11 -0500
Received: from isilmar.linta.de ([213.239.214.66]:41389 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S261338AbVCFIJ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 03:09:59 -0500
Date: Sun, 6 Mar 2005 09:09:54 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Daniel Rozsnyo <daniel@rozsnyo.com>
Cc: Linus Torvalds <torvalds@ppc970.osdl.org>, linux-kernel@vger.kernel.org,
       Daniel Rozsnyo <rozsnyo@kn.vutbr.cz>
Subject: Re: [PATCH] i386: remove extra spaces from cpu model id
Message-ID: <20050306080954.GA26158@isilmar.linta.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Daniel Rozsnyo <daniel@rozsnyo.com>,
	Linus Torvalds <torvalds@ppc970.osdl.org>,
	linux-kernel@vger.kernel.org, Daniel Rozsnyo <rozsnyo@kn.vutbr.cz>
References: <Pine.LNX.4.62.0503060824410.18717@a03-0431e.kn.vutbr.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0503060824410.18717@a03-0431e.kn.vutbr.cz>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 06, 2005 at 08:32:22AM +0100, Daniel Rozsnyo wrote:
> Removes extra spaces which separate the frequency string from the cpu model 
> id itself (noticable e.g. on Intel Tualatin processors in /proc/cpuinfo)
> 
> Signed-off-by: Daniel Rozsnyo <daniel@rozsnyo.com>

This patch breaks speedstep-centrino for 900 MHz Banias CPUs. Also,
I'd prefer to keep this the way it is reported by the CPU itself [except the
left/right padding], of course.

	Dominik
