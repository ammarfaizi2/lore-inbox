Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266530AbUAWHt7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 02:49:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266537AbUAWHt7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 02:49:59 -0500
Received: from delerium.codemonkey.org.uk ([81.187.208.145]:38311 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S266530AbUAWHt6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 02:49:58 -0500
Date: Fri, 23 Jan 2004 07:48:34 +0000
From: Dave Jones <davej@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: Remove useless cruft from ATM HE driver.
Message-ID: <20040123074834.GG9327@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	torvalds@osdl.org
References: <E1Ajuub-0000xS-00@hardwired> <20040122233510.216f4358.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040122233510.216f4358.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 22, 2004 at 11:35:10PM -0800, Andrew Morton wrote:
 > davej@redhat.com wrote:
 > >
 > > Echoing changes done in 2.4. (It now has a pci_pool_create backport).
 > 
 > drivers/atm/he.c: In function `he_start':
 > drivers/atm/he.c:1474: too many arguments to function `pci_pool_create'

Gah, pci_pool_create is already suitably neutered in 2.6 (only takes 5 args).
Kill all the hunks except the first.

	Dave

