Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932273AbVJDPUU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932273AbVJDPUU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 11:20:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932353AbVJDPUU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 11:20:20 -0400
Received: from mail.dvmed.net ([216.237.124.58]:44716 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932273AbVJDPUS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 11:20:18 -0400
Message-ID: <43429D9E.2020600@pobox.com>
Date: Tue, 04 Oct 2005 11:19:58 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roger Luethi <rl@hellgate.ch>
CC: Denis Vlasenko <vda@ilport.com.ua>, Patrick Draper <pdraper@gmail.com>,
       Udo van den Heuvel <udovdh@xs4all.nl>, linux-kernel@vger.kernel.org
Subject: Re: VIA Rhine ethernet driver bug (reprise...)
References: <430A0B69.1060304@xs4all.nl> <200508231221.59299.vda@ilport.com.ua> <6981e08b0508252043139cfa2d@mail.gmail.com> <200508260933.45402.vda@ilport.com.ua> <430EC985.6040307@pobox.com> <20050826090412.GA20288@k3.hellgate.ch>
In-Reply-To: <20050826090412.GA20288@k3.hellgate.ch>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ah, ok.

The central problem is that the 'forced_media' attribute is intended in 
all respects to force the media into the specified mode. 
Auto-negotiation is disabled, and link is always assumed to be up.

	Jeff



