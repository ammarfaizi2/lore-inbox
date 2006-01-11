Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932508AbWAKSfz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932508AbWAKSfz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 13:35:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932515AbWAKSfy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 13:35:54 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:7618 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932508AbWAKSfx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 13:35:53 -0500
Date: Wed, 11 Jan 2006 19:35:44 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Jakub Jelinek <jakub@redhat.com>
cc: "David S. Miller" <davem@davemloft.net>, drepper@redhat.com,
       arjan@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: ntohs/ntohl and bitops
In-Reply-To: <20060111094854.GK7768@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.61.0601111935340.19259@yvahk01.tjqt.qr>
References: <20060111.000020.25886635.davem@davemloft.net>
 <1136967192.2929.6.camel@laptopd505.fenrus.org> <43C4C37B.9020801@redhat.com>
 <20060111.004418.92939254.davem@davemloft.net> <20060111094854.GK7768@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Does it work for comparisons?  F.e.:
>> 
>>      if (val < ntohs(VAL))
>
>No, only for ==, !=, &, |, ~.

And ^?


Jan Engelhardt
-- 
