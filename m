Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261409AbULTETU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261409AbULTETU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Dec 2004 23:19:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261411AbULTETU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Dec 2004 23:19:20 -0500
Received: from mx1.redhat.com ([66.187.233.31]:2788 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261409AbULTETR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Dec 2004 23:19:17 -0500
Date: Sun, 19 Dec 2004 23:18:56 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Con Kolivas <kernel@kolivas.org>
cc: Mikhail Ramendik <mr@ramendik.ru>, Andrew Morton <akpm@digeo.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, lista4@comhem.se,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc3: kswapd eats CPU on start of memory-eating task
In-Reply-To: <41C65169.4020508@kolivas.org>
Message-ID: <Pine.LNX.4.61.0412192317470.4315@chimarrao.boston.redhat.com>
References: <14514245.1103496059334.JavaMail.tomcat@pne-ps4-sn2>
 <41C6073B.6030204@yahoo.com.au> <20041219155722.01b1bec0.akpm@digeo.com>
 <200412200303.35807.mr@ramendik.ru> <41C640DE.7050002@kolivas.org>
 <Pine.LNX.4.61.0412192220450.4315@chimarrao.boston.redhat.com>
 <41C65169.4020508@kolivas.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Dec 2004, Con Kolivas wrote:

> What if the token isn't handed out at all until a heavy swapping load 
> starts? A slight delay in thrash control would be worth it.

How do you define "heavy swapping" ?

How would you measure it ?

How would you relinquish the token after the "heavy swapping"
load stopped ?

-- 
He did not think of himself as a tourist; he was a traveler. The difference is
partly one of time, he would explain. Where as the tourist generally hurries
back home at the end of a few weeks or months, the traveler belonging no more
to one place than to the next, moves slowly, over periods of years, from one
part of the earth to another. Indeed, he would have found it difficult to tell,
among the many places he had lived, precisely where it was he had felt most at
home.  -- Paul Bowles
