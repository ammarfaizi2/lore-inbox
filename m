Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264982AbTGGOPk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 10:15:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264992AbTGGOPk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 10:15:40 -0400
Received: from host-64-213-145-173.atlantasolutions.com ([64.213.145.173]:57319
	"EHLO havoc.gtf.org") by vger.kernel.org with ESMTP id S264982AbTGGOPj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 10:15:39 -0400
Date: Mon, 7 Jul 2003 10:30:11 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Patrick McHardy <kaber@trash.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@oss.sgi.com
Subject: Re: RFC: another approach for 64-bit network stats
Message-ID: <20030707143011.GA14787@gtf.org>
References: <3F097E4D.1080707@trash.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F097E4D.1080707@trash.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If you don't want to poll periodically for network stats, as has
been repeatedly suggested, you can always poll periodically for the
64-bit NIC-specific stats that most gige adapters provide these days,
using ethtool.  NIC-specific stats also tend to provide more fine
granularity than the current net_device_stats members.

	Jeff



