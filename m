Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261850AbUJ1TT7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261850AbUJ1TT7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 15:19:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261866AbUJ1TT7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 15:19:59 -0400
Received: from basmati.dododge.net ([204.245.156.209]:30425 "HELO
	basmati.dododge.net") by vger.kernel.org with SMTP id S261850AbUJ1TTw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 15:19:52 -0400
Date: Thu, 28 Oct 2004 15:31:17 -0400
From: Dave Dodge <dododge@dododge.net>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org, uclibc@uclibc.org
Subject: Re: [uClibc] Swap strangeness: total VIRT ~23mb for all processes, swap 91156k used - impossible?
Message-ID: <20041028193117.GA29348@basmati>
References: <200410281333.53976.vda@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410281333.53976.vda@port.imtp.ilyichevsk.odessa.ua>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2004 at 01:33:53PM +0300, Denis Vlasenko wrote:
> Output puzzles me: total virtual space taken by *all*
> processes is ~23mb yet swap usage is ~90mb.
> 
> How that can be? *What* is there? Surely it can't
> be a filesystem cache because OOM condition reduces that
> to nearly zero.

Just a thought: do you have a tmpfs mounted anywhere?

                                                  -Dave Dodge
