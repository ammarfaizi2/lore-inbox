Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261299AbTLDUVl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 15:21:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262591AbTLDUVk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 15:21:40 -0500
Received: from pizda.ninka.net ([216.101.162.242]:50349 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S261299AbTLDUVk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 15:21:40 -0500
Date: Thu, 4 Dec 2003 12:20:22 -0800
From: "David S. Miller" <davem@redhat.com>
To: Stephen Lee <mukansai@emailplus.org>
Cc: scott.feldman@intel.com, laforge@netfilter.org,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org
Subject: Re: Extremely slow network with e1000 & ip_conntrack
Message-Id: <20031204122022.5250b104.davem@redhat.com>
In-Reply-To: <20031205045020.4C0E.MUKANSAI@emailplus.org>
References: <C6F5CF431189FA4CBAEC9E7DD5441E0102CBDD21@orsmsx402.jf.intel.com>
	<20031205045020.4C0E.MUKANSAI@emailplus.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 05 Dec 2003 04:53:33 +0900
Stephen Lee <mukansai@emailplus.org> wrote:

> I have a 32-bit PCI card with bcm5705 on it, does that support TSO? 
> I'll give it a try today.

Yep it does, but it is not enabled by default.  You have
to enable it explicitly using ethtool.

