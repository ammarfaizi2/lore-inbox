Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261580AbTIKWQJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 18:16:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261581AbTIKWQJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 18:16:09 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:57235 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S261580AbTIKWQD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 18:16:03 -0400
Subject: Re: Size of Tasks during ddos
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Breno <brenosp@brasilsec.com.br>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <008901c39044$597dd320$f8e4a7c8@bsb.virtua.com.br>
References: <001b01c39047$d65cf580$f8e4a7c8@bsb.virtua.com.br>
	 <20030911002755.GA13177@triplehelix.org> <3F5FD993.2060900@ccs.neu.edu>
	 <009201c37860$f0d3c5f0$131215ac@poslab219>
	 <200309111419.h8BEJbSo010948@turing-police.cc.vt.edu>
	 <009f01c3788a$08b7f780$9f0210ac@forumci.com.br>
	 <1063305670.3605.0.camel@dhcp23.swansea.linux.org.uk>
	 <002801c3789e$7a665ac0$9f0210ac@forumci.com.br>
	 <1063312815.3886.0.camel@dhcp23.swansea.linux.org.uk>
	 <008901c39044$597dd320$f8e4a7c8@bsb.virtua.com.br>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063318487.3886.19.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-5) 
Date: Thu, 11 Sep 2003 23:14:48 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2003-10-11 at 23:09, Breno wrote:
> Suppose that one task during a ddos receive much data , so it can try to
> alloc much memory to control this data, or to control the list of sockets in
> listen state.

Syncookies dont allocate memory until the connection finishes the 3 way
handshake with the other side

