Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269015AbUIQVdQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269015AbUIQVdQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 17:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269182AbUIQVdP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 17:33:15 -0400
Received: from holomorphy.com ([207.189.100.168]:23215 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269015AbUIQVdI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 17:33:08 -0400
Date: Fri, 17 Sep 2004 14:32:58 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Larry McVoy <lm@bitmover.com>, viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: top hogs CPU in 2.6: kallsyms_lookup is very slow
Message-ID: <20040917213258.GB9106@holomorphy.com>
References: <200409161428.27425.vda@port.imtp.ilyichevsk.odessa.ua> <200409171532.58898.vda@port.imtp.ilyichevsk.odessa.ua> <20040917133330.GR9106@holomorphy.com> <200409172336.25695.vda@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409172336.25695.vda@port.imtp.ilyichevsk.odessa.ua>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2004 at 11:36:25PM +0300, Denis Vlasenko wrote:
> Aha! Maybe it's just a might_sleep() overhead?

How does 2.6 do with those might_sleep() calls removed?


-- wli
