Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275349AbTHGOCl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 10:02:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275350AbTHGOCl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 10:02:41 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:48859 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S275349AbTHGOCh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 10:02:37 -0400
Date: Thu, 7 Aug 2003 16:02:32 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Pawel Dziekonski <pawel.dziekonski@pwr.wroc.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.22-pre10-ac1 -- lots of unresolved symbols
Message-ID: <20030807140232.GC7094@louise.pinerecords.com>
References: <20030807133053.GA18191@pwr.wroc.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030807133053.GA18191@pwr.wroc.pl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [pawel.dziekonski@pwr.wroc.pl]
> 
> I just got lots of unresolved symbols for 2.4.22-pre10-ac1, please help.
> thanks in advance, P

Save your .config, "make mrproper", cp in your .config, "make oldconfig",
rebuild.

There are certain config options (for instance SMP) the toggling of which
requires this procedure.

-- 
Tomas Szepe <szepe@pinerecords.com>
