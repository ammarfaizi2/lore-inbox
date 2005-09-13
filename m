Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932224AbVIMFOf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932224AbVIMFOf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 01:14:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932232AbVIMFOf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 01:14:35 -0400
Received: from ncc1701.cistron.net ([62.216.30.38]:35202 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP id S932224AbVIMFOf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 01:14:35 -0400
From: dth@cistron.nl (Danny ter Haar)
Subject: Re: 2.6.13-mm3
Date: Tue, 13 Sep 2005 05:14:34 +0000 (UTC)
Organization: Cistron
Message-ID: <dg5n7q$daf$1@news.cistron.nl>
References: <20050912024350.60e89eb1.akpm@osdl.org> <20050912200914.GA13962@kevlar.burdell.org> <dg4qeg$27m$1@news.cistron.nl> <20050912220617.GA18215@kevlar.burdell.org>
X-Trace: ncc1701.cistron.net 1126588474 13647 62.216.30.70 (13 Sep 2005 05:14:34 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: dth@cistron.nl (Danny ter Haar)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sonny Rao  <sonny@burdell.org> wrote:
>Are you using jumbo frames or anything like that?

Not as far as i know.

I gave the kernel some more buffer as stated on
http://home.cern.ch/~jes/gige/acenic.html

echo 256144 > /proc/sys/net/core/rmem_max
echo 262144 > /proc/sys/net/core/wmem_max

>I can probably replicate order > 0 allocation failures pretty easily 
>using that, but I don't know if that's really the issue.

I don't think that's the case , on this machine.

Danny

