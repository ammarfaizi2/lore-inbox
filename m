Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269950AbTGWLIg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 07:08:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270069AbTGWLIg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 07:08:36 -0400
Received: from wilsoaa1.miniserver.com ([69.10.141.73]:34832 "HELO
	china.botanicus.net") by vger.kernel.org with SMTP id S269950AbTGWLIf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 07:08:35 -0400
Date: Wed, 23 Jul 2003 12:24:37 +0100
From: "David M. Wilson" <dw_lkml@botanicus.net>
To: jimis@gmx.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: Feature proposal (scheduling related)
Message-ID: <20030723112437.GA8515@china.botanicus.net>
References: <3F1E6A25.5030308@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F1E6A25.5030308@gmx.net>
X-Setup: Linux 2.4.20-4um, et:tw=75
X-WWW: http://botanicus.net/dw/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 23, 2003 at 01:57:41PM +0300, jimis@gmx.net wrote:

> 1)I 'm connected to the internet via dial-up, therefore I only have 40 
> kbits of bandwidth available. What I want to do is listen to icecast radio 
> via xmms (at 22 kbits), download the kernel sources with wget, and browse 
> the web at the same time. Currently I think that this is *impossible* 
> (correct me if I'm wrong) as the radio will be full of pauses and the 
> browsing experience painfully slow. What I would like to be able to do 
> (let's suppose nice has the --net option to set net I/O priority):
> $ nice --net -1 xmms
> $ nice --net 1 wget ftp://.../KernelSources.tar.bz2
> $ mozilla

I think what you need to look at is network-level QoS, this is far too
intrusive for what you are trying to do. Try tldp.org.

David.
