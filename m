Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261232AbVFAAxc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbVFAAxc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 20:53:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261237AbVFAAxc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 20:53:32 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:50586 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261232AbVFAAxU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 20:53:20 -0400
Date: Tue, 31 May 2005 17:45:46 -0400
From: Christopher Li <lkml@chrisli.org>
To: "E.Gryaznova" <grev@namesys.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc5-mm1: configuring vmware workstation modules
Message-ID: <20050531214546.GD2999@64m.dyndns.org>
References: <429B9D00.1070404@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <429B9D00.1070404@namesys.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please try the module from Petr's page,

http://platan.vc.cvut.cz/ftp/pub/vmware

This is cause by a recent kernel API change in sk_alloc.

Chris

> /tmp/vmware-config5/vmnet-only/bridge.c: In function `VNetBridgeUp':
> /tmp/vmware-config5/vmnet-only/bridge.c:716: warning: passing arg 3 of 
> `sk_alloc' makes pointer from integer without a cast

