Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263508AbTIBFzW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 01:55:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263526AbTIBFzV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 01:55:21 -0400
Received: from fed1mtao01.cox.net ([68.6.19.244]:18406 "EHLO
	fed1mtao01.cox.net") by vger.kernel.org with ESMTP id S263508AbTIBFzT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 01:55:19 -0400
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: dontdiff for 2.6.0-test4
References: <3F53F142.5050909@pobox.com>
	<Pine.GSO.4.44.0309010754480.1106-100000@north.veritas.com>
	<20030901163958.A24464@infradead.org>
	<20030901162244.GA1041@mars.ravnborg.org> <3F537CDD.3040809@pobox.com>
	<20030901171806.GB1041@mars.ravnborg.org>
	<7vk78rykzb.fsf@assigned-by-dhcp.cox.net> <3F5404A4.4080700@pobox.com>
From: Junio C Hamano <junkio@cox.net>
Date: Mon, 01 Sep 2003 22:55:17 -0700
In-Reply-To: <3F5404A4.4080700@pobox.com> (Jeff Garzik's message of "Mon, 01
 Sep: 47:00 -0400")
Message-ID: <7vfzjfybsq.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "JG" == Jeff Garzik <jgarzik@pobox.com> writes:

JG> People are thinking _way_ too hard about this.  This is just plunking
JG> a rarely-changing file into the kernel tree.  Even implying some sort
JG> of maintenance hassle is making a mountain out of a molehill.

The last sentence I agree---it is really not a big deal.  But if
the thing is rarely changed, more likely people would forget to
update one when changing the other, wouldn't they?

In any case, either the dontdiff and mrproper are maintained
separately or not, I am in favor of having dontdiff in the
kernel tree.

