Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750809AbWDQMde@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750809AbWDQMde (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 08:33:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750804AbWDQMde
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 08:33:34 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:45193 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750809AbWDQMdd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 08:33:33 -0400
Date: Mon, 17 Apr 2006 13:33:29 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Felipe Maya <fmay@midiacom.uff.br>
Cc: linux mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: Packet Transmit Amateur progammer!!
Message-ID: <20060417123329.GQ27946@ftp.linux.org.uk>
References: <1145280720.6657.18.camel@fmay.midiacom.uff.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1145280720.6657.18.camel@fmay.midiacom.uff.br>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2006 at 09:31:59AM -0400, Felipe Maya wrote:
> Hi, I am trying to send one packet in one Congestion Agent.  I am
> Amateur kernel programmer, I want to know what is wrong in this

How about
	a) 0.7Kb on stach, for starters
	b) the only occurences of "data" below being
> 	unsigned char data[700];
and 
> 	tcp_header_size = MAX_TCP_HEADER + sizeof(data);

Is that really what you meant to do there?
