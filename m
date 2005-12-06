Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030288AbVLFXDr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030288AbVLFXDr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 18:03:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030290AbVLFXDr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 18:03:47 -0500
Received: from baythorne.infradead.org ([81.187.2.161]:63384 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S1030288AbVLFXDq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 18:03:46 -0500
Subject: Re: Linux in a binary world... a doomsday scenario
From: David Woodhouse <dwmw2@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Brian Gerst <bgerst@didntduck.org>, Andrea Arcangeli <andrea@suse.de>,
       William Lee Irwin III <wli@holomorphy.com>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
In-Reply-To: <1133909359.26777.4.camel@localhost.localdomain>
References: <1133779953.9356.9.camel@laptopd505.fenrus.org>
	 <20051205121851.GC2838@holomorphy.com>
	 <20051206011844.GO28539@opteron.random> <43944F42.2070207@didntduck.org>
	 <20051206030828.GA823@opteron.random>  <4394696B.6060008@didntduck.org>
	 <1133894575.4136.171.camel@baythorne.infradead.org>
	 <1133897035.23610.32.camel@localhost.localdomain>
	 <1133907922.4136.218.camel@baythorne.infradead.org>
	 <1133909359.26777.4.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 06 Dec 2005 23:03:41 +0000
Message-Id: <1133910221.4136.229.camel@baythorne.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-12-06 at 22:49 +0000, Alan Cox wrote:
> The video 'solution' is a combination of digital and analog
> components. Intel defined one end only. Its a bit like AC97 audio only
> as I understand it rather less structured. 
> 
> Note that most of the BIOS fixes don't replace the BIOS code, they
> provide extra mode table entries to it.

AIUI we can't even add 'extra' mode table entries -- we can only modify
existing entries, and we can't even set the full modeline information on
some systems because we haven't reverse-engineered the tables
completely.

It's done by copying the video BIOS into shadow RAM and modifying the
table in RAM. This isn't really much of an improvement over binary-only
drivers.

-- 
dwmw2


