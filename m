Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270063AbTGNKy5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 06:54:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270072AbTGNKy5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 06:54:57 -0400
Received: from raq465.uk2net.com ([213.239.56.46]:27141 "EHLO
	mail.truemesh.com") by vger.kernel.org with ESMTP id S270063AbTGNKy4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 06:54:56 -0400
Date: Mon, 14 Jul 2003 12:03:35 +0100
From: Paul Nasrat <pauln@truemesh.com>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test1: Hang during boot on Intel D865PERL motherboard
Message-ID: <20030714110335.GQ28359@raq465.uk2net.com>
Mail-Followup-To: Paul Nasrat <pauln@truemesh.com>,
	Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
	linux-kernel@vger.kernel.org
References: <20030714110311.6059.qmail@linuxmail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030714110311.6059.qmail@linuxmail.org>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 14, 2003 at 12:03:11PM +0100, Felipe Alfaro Solana wrote:
> Hi,
> 
> I've compiled linux-2.6.0-test1 kernel with the attached "config" file. When trying to boot the kernel, it hangs on "Uncompress Linux kernel...OK". The system is:

You only have the dummy console selected ensuring you have:

CONFIG_CONSOLE_VGA=y

Should display things to screen.

Paul
