Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264979AbUF1Ot6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264979AbUF1Ot6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 10:49:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264984AbUF1Ot6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 10:49:58 -0400
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:10211 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S264979AbUF1Ot5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 10:49:57 -0400
Date: Mon, 28 Jun 2004 07:49:45 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Miquel van Smoorenburg <miquels@cistron.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: TCP-RST Vulnerability - Doubt
Message-ID: <20040628144945.GB11481@taniwha.stupidest.org>
References: <40DC9B00@webster.usu.edu> <20040625150532.1a6d6e60.davem@redhat.com> <cbp62t$a38$1@news.cistron.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbp62t$a38$1@news.cistron.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 28, 2004 at 01:22:37PM +0000, Miquel van Smoorenburg wrote:

> The "TTL hack" solution is safer. Make sure sender uses a TTL of
> 255, on the receiver discard all packets with a TTL < 255.  You can
> use iptables to implement that on a Linux box.

Breaks with eBGP multi-hop so you have to adjust as required there.


  --cw
