Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262671AbVAEXw7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262671AbVAEXw7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 18:52:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262668AbVAEXw7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 18:52:59 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:7318 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S262664AbVAEXww
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 18:52:52 -0500
Date: Thu, 6 Jan 2005 00:51:08 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: linux-kernel@vger.kernel.org, hubert.tonneau@fullpliant.org
Subject: Re: 2.6.10 TCP troubles
Message-ID: <20050105235108.GA12014@electric-eye.fr.zoreil.com>
References: <05081I514@server5.heliogroup.fr> <20050105153307.739ef5d8@dxpl.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050105153307.739ef5d8@dxpl.pdx.osdl.net>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Hemminger <shemminger@osdl.org> :
[...]
> 	Is there window scaling or other issues?  Does 2.6.10 get faster if

Bingo !

tcpdump exhibits a 2^5 factor differences in the advertised window when
the network speed is low.

--
Ueimor
