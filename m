Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932336AbWCMIC6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932336AbWCMIC6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 03:02:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932337AbWCMIC6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 03:02:58 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:14165
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S932336AbWCMIC5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 03:02:57 -0500
Message-Id: <4415354C.76F0.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Mon, 13 Mar 2006 09:03:08 +0100
From: "Jan Beulich" <JBeulich@novell.com>
To: "Sam Ravnborg" <sam@ravnborg.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix time ordering of writes to .kconfig.d and
	include/linux/autoconf.h
References: <44104012.76F0.0078.0@novell.com> <20060312224328.GD23326@mars.ravnborg.org>
In-Reply-To: <20060312224328.GD23326@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Sam Ravnborg <sam@ravnborg.org> 12.03.06 23:43:28 >>>
>On Thu, Mar 09, 2006 at 02:47:46PM +0100, Jan Beulich wrote:
>> Since .kconfig.d is used as a make dependency of include/linux/autoconf.h, it
>> should be written earlier than the header file, to avoid a subsequent rebuild
>> to consider the header outdated.
>
>Thanks Jan. I assume you saw this in reality?

Yes, I did.

>Applied.

Thanks, Jan
