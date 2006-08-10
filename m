Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751480AbWHJJd6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751480AbWHJJd6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 05:33:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751483AbWHJJd6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 05:33:58 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:3141 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1751480AbWHJJd6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 05:33:58 -0400
Message-ID: <44DAFDCA.6090100@sw.ru>
Date: Thu, 10 Aug 2006 13:35:06 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Muli Ben-Yehuda <muli@il.ibm.com>,
       =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
       linux-kernel@vger.kernel.org, dev@openvz.org, stable@kernel.org
Subject: Re: + sys_getppid-oopses-on-debug-kernel.patch added to -mm tree
References: <200608081432.k78EWprf007511@shell0.pdx.osdl.net> <20060808143937.GA3953@rhun.haifa.ibm.com> <20060808145138.GA2720@atjola.homenet> <20060808145709.GB3953@rhun.haifa.ibm.com> <1155050547.5729.91.camel@localhost.localdomain> <44D8B048.8060103@sw.ru> <20060808163635.GF28990@redhat.com> <44D99901.20202@sw.ru> <20060809173830.GA10930@redhat.com>
In-Reply-To: <20060809173830.GA10930@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Then you're correct, vendors rarely turn this on :)
> I do sometimes if I'm trying to chase down something particularly
> difficult, and it usually gets me a bunch of mail from users
> asking why 'everything got all slow', so it's a last-resort option
> rather than a 'on all the time' option.
Yeah, maybe it is a last resort option for users, but at least for internal
testing it helps. We regularly run such debug kernel through testing cycle
and it catches some races from time to time.

Kirill

