Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751926AbWIHANc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751926AbWIHANc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 20:13:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751928AbWIHANc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 20:13:32 -0400
Received: from smtp104.sbc.mail.mud.yahoo.com ([68.142.198.203]:35177 "HELO
	smtp104.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751926AbWIHANb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 20:13:31 -0400
Date: Thu, 7 Sep 2006 17:13:25 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Kirill Korotaev <dev@openvz.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrey Mirkin <amirkin@sw.ru>, devel@openvz.org, mikpe@it.uu.se,
       sam@ravnborg.org, bunk@stusta.de
Subject: Re: [PATCH] fail kernel compilation in case of unresolved symbols (v2)
Message-ID: <20060908001325.GA1559@tuatara.stupidest.org>
References: <44FFEE5D.2050905@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44FFEE5D.2050905@openvz.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2006 at 02:03:09PM +0400, Kirill Korotaev wrote:

> At stage 2 modpost utility is used to check modules.  In case of
> unresolved symbols modpost only prints warning.

please don't, i get bogus warnings for some drivers when
cross-compiling, this would create problems for little or no gain

