Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753837AbWKIHr5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753837AbWKIHr5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 02:47:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753845AbWKIHr5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 02:47:57 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:43242 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1753837AbWKIHr5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 02:47:57 -0500
Date: Thu, 9 Nov 2006 10:48:01 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: zhou drangon <drangon.mail@gmail.com>, linux-kernel@vger.kernel.org,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: [take22 0/4] kevent: Generic event handling mechanism.
Message-ID: <20061109074801.GA23572@2ka.mipt.ru>
References: <slrnekhpbr.2j1.olecom@flower.upol.cz> <20061101185745.GA12440@2ka.mipt.ru> <5c49b0ed0611011812w8813df3p830e44b6e87f09f4@mail.gmail.com> <aaf959cb0611011829k36deda6ahe61bcb9bf8e612e1@mail.gmail.com> <aaf959cb0611011830j1ca3e469tc4a6af3a2a010fa@mail.gmail.com> <4549A261.9010007@cosmosbay.com> <20061102080122.GA1302@2ka.mipt.ru> <454FA671.7000204@cosmosbay.com> <20061107091842.GA4608@2ka.mipt.ru> <20061107120921.GA4742@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20061107120921.GA4742@2ka.mipt.ru>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Thu, 09 Nov 2006 10:48:02 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Kevent pipe benchmark kevent_pipe kernel kevent part:

epoll (edge-triggered):   248408 events/sec
kevent (edge-triggered):  269282 events/sec
Busy reading loop:        269519 events/sec

Kevent is definitely a winner with extremely small overhead.

I will add kevent_pipe into next kevent release which will be available
soon.

-- 
	Evgeniy Polyakov
