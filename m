Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751093AbVI1QHv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093AbVI1QHv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 12:07:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751095AbVI1QHv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 12:07:51 -0400
Received: from ams-iport-1.cisco.com ([144.254.224.140]:32544 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1751093AbVI1QHt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 12:07:49 -0400
To: Arjan van de Ven <arjan@infradead.org>
Cc: dwalker@mvista.com, mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RT: epca_lock to DEFINE_SPINLOCK
X-Message-Flag: Warning: May contain useful information
References: <1127845928.4004.24.camel@dhcp153.mvista.com>
	<1127900349.2893.19.camel@laptopd505.fenrus.org>
From: Roland Dreier <rolandd@cisco.com>
Date: Wed, 28 Sep 2005 09:06:33 -0700
In-Reply-To: <1127900349.2893.19.camel@laptopd505.fenrus.org> (Arjan van de
 Ven's message of "Wed, 28 Sep 2005 11:39:09 +0200")
Message-ID: <52irwlmb1y.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 28 Sep 2005 16:06:35.0612 (UTC) FILETIME=[99BF19C0:01C5C446]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Arjan> this is really ugly though; at minimum a DEFINE_STATIC_SPINLOCK()
    Arjan>  would be needed to make this less ugly.

huh?  This is a totally standard kernel idiom -- just do

    grep -Er 'static (DECLARE|DEFINE)' .

in a kernel tree to see how prevalent it is.

 - R.
