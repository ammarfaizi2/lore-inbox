Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269442AbUJFU1H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269442AbUJFU1H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 16:27:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269447AbUJFUIH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 16:08:07 -0400
Received: from dspnet.fr.eu.org ([62.73.5.179]:47369 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S269442AbUJFUGK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 16:06:10 -0400
Date: Wed, 6 Oct 2004 22:06:08 +0200
From: Olivier Galibert <galibert@pobox.com>
To: "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
Message-ID: <20041006200608.GA29180@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	'Linux Kernel Mailing List' <linux-kernel@vger.kernel.org>
References: <20041006193053.GC4523@pclin040.win.tue.nl> <003301c4abdc$c043f350$b83147ab@amer.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <003301c4abdc$c043f350$b83147ab@amer.cisco.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 06, 2004 at 12:43:27PM -0700, Hua Zhong wrote:
> How hard is it to treat the next read to the fd as NON_BLOCKING, even if
> it's not set?

Programs don't expect EAGAIN from blocking sockets.

  OG.
