Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271038AbTG2A6J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 20:58:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271207AbTG2A6J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 20:58:09 -0400
Received: from crosslink-village-512-1.bc.nu ([81.2.110.254]:19694 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S271038AbTG2A6H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 20:58:07 -0400
Subject: Re: request_region for no dynamic bus sizing
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: yashi@atmark-techno.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030728235555.5D4C03E610@dns1.atmark-techno.com>
References: <20030728235555.5D4C03E610@dns1.atmark-techno.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1059439949.1870.6.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 29 Jul 2003 01:52:29 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-07-29 at 00:55, Yasushi SHOJI wrote:
> the problem is, however, that because there is two memory region for
> one bus address, I have to call two request_region()s to avoid misuse.
> 
> what i'd like to ask is that "is anyone using such kind of board to
> run linux? if so, how do you do?"

Is there any reason you cannot fix request_region for your platform to
request both itself ?

