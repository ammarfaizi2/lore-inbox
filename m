Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261672AbUCFOZK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Mar 2004 09:25:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261674AbUCFOZK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Mar 2004 09:25:10 -0500
Received: from delerium.kernelslacker.org ([81.187.208.145]:22935 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S261672AbUCFOZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Mar 2004 09:25:07 -0500
Date: Sat, 6 Mar 2004 14:24:01 +0000
From: Dave Jones <davej@redhat.com>
To: Voicu Liviu <pacman@mscc.huji.ac.il>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6-use-register-arguments.patch
Message-ID: <20040306142401.GA18936@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Voicu Liviu <pacman@mscc.huji.ac.il>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <4049DDF3.5080500@mscc.huji.ac.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4049DDF3.5080500@mscc.huji.ac.il>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 06, 2004 at 04:19:31PM +0200, Voicu Liviu wrote:
 > fglrx: module license 'Proprietary. (C) 2002 - ATI Technologies, 

fireglx needs changing to cope with -mregparm=3.
You might get away with just changing the wrapper *maybe*.
If not, it's ATI's problem, not ours. If you can't fix it,
don't enable that option.

		Dave

