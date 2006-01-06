Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751481AbWAFM5L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751481AbWAFM5L (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 07:57:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751483AbWAFM5L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 07:57:11 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:51106 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751481AbWAFM5K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 07:57:10 -0500
Subject: Re: High load
From: Arjan van de Ven <arjan@infradead.org>
To: Aniruddh Singh <aps@jobsahead.com>
Cc: Con Kolivas <kernel@kolivas.org>, linux <linux-kernel@vger.kernel.org>
In-Reply-To: <1136550971.5557.2.camel@aps.monsterindia.noida>
References: <1136454597.6016.7.camel@aps.monsterindia.noida>
	 <200601052100.45107.kernel@kolivas.org>
	 <1136550971.5557.2.camel@aps.monsterindia.noida>
Content-Type: text/plain
Date: Fri, 06 Jan 2006 13:57:06 +0100
Message-Id: <1136552226.2940.35.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-01-06 at 18:06 +0530, Aniruddh Singh wrote:
> Hi,
> 
> there is a raid 0 and raid controller is Smart Array 64xx (rev 01)
> 
> hdparm -tT /dev/cciss/c0d0p2 returns the following

for measuring IO performance, I'd recommend tiobench over hdparm any day
( http://tiobench.sf.net )



