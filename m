Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262114AbVCNXSI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262114AbVCNXSI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 18:18:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262078AbVCNXQc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 18:16:32 -0500
Received: from avexch01.qlogic.com ([198.70.193.200]:17224 "EHLO
	avexch01.qlogic.com") by vger.kernel.org with ESMTP id S262114AbVCNXQD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 18:16:03 -0500
Date: Mon, 14 Mar 2005 15:16:30 -0800
From: Andrew Vasquez <andrew.vasquez@qlogic.com>
To: comsatcat <comsatcat@earthlink.net>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: qla2xxx fail over support
Message-ID: <20050314231630.GB8548@plap.qlogic.org>
Mail-Followup-To: comsatcat <comsatcat@earthlink.net>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>
References: <1110838136.12171.4.camel@solaris.zataoh.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1110838136.12171.4.camel@solaris.zataoh.com>
Organization: QLogic Corporation
X-Operating-System: Linux 2.6.8-24.11-default
User-Agent: Mutt/1.5.6i
X-OriginalArrivalTime: 14 Mar 2005 23:15:47.0333 (UTC) FILETIME=[C12D6350:01C528EB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Mar 2005, comsatcat wrote:

> 
> Is the qla2xxx dirver not capable of fail over support?  under
> Documentation/* for the qla2xxx release notes, it says in a earlier
> revision that fail over was made optional.  Was the optional support
> removed?  If it is capable of fail over, what are the means of
> enable/accessing the ability?
> 

Failover support for a variety of reasons has been removed from the
embedded 2.6.x kernel driver.  If you are interested in continuing to
use the failover functionality you will need to use one of the drivers
in:

	ftp://ftp.qlogic.com/outgoing/linux/beta/8.x/

more specifically:

	ftp://ftp.qlogic.com/outgoing/linux/beta/8.x/qla2xxx-v8.00.02b10-dist.tgz

Regards,
Andrew Vasquez
