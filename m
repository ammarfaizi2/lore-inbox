Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932486AbVLESBL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932486AbVLESBL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 13:01:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932491AbVLESBL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 13:01:11 -0500
Received: from hera.kernel.org ([140.211.167.34]:40647 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S932486AbVLESBJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 13:01:09 -0500
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: virtual interface mac adress
Date: Mon, 5 Dec 2005 10:01:04 -0800
Organization: OSDL
Message-ID: <20051205100104.08537752@localhost.localdomain>
References: <20051204192958.64093.qmail@web60214.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1133805665 21696 10.8.0.222 (5 Dec 2005 18:01:05 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Mon, 5 Dec 2005 18:01:05 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 1.9.100 (GTK+ 2.6.10; x86_64-redhat-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Dec 2005 11:29:58 -0800 (PST)
anil dahiya <ak_ait@yahoo.com> wrote:

> Hi 
> I want to assign mac addres to virtual adpater and mac
> address should be like that if it should not create
> problem in arp resoultion(i.e. mac address should be
> as real card which able to comunicate  on lan )
> 
> waiting for ur reply,
> Anil 
> 

use random_ether_addr (see include/linux/etherdevice.h)

-- 
Stephen Hemminger <shemminger@osdl.org>
OSDL http://developer.osdl.org/~shemminger
