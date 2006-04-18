Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932243AbWDRGIB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932243AbWDRGIB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 02:08:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932244AbWDRGIA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 02:08:00 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:51171 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S932243AbWDRGIA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 02:08:00 -0400
Date: Tue, 18 Apr 2006 10:07:44 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Libor Vanek <libor.vanek@gmail.com>
Cc: Matt Helsley <matthltc@us.ibm.com>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Connector - how to start?
Message-ID: <20060418060744.GA20715@2ka.mipt.ru>
References: <369a7ef40604141809u45b7b37ay27dfb74778a91893@mail.gmail.com> <20060414192634.697cd2e3.rdunlap@xenotime.net> <1145070437.28705.73.camel@stark> <20060415091801.GA4782@2ka.mipt.ru> <369a7ef40604160426s301dcd52r4c9826698d3d2f79@mail.gmail.com> <20060416114017.GA30180@2ka.mipt.ru> <369a7ef40604160509xcf2caadi782b90da956639d5@mail.gmail.com> <20060416132515.GA25602@2ka.mipt.ru> <369a7ef40604160632t16f6aab9u687a6b359997d7ea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <369a7ef40604160632t16f6aab9u687a6b359997d7ea@mail.gmail.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Tue, 18 Apr 2006 10:07:45 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bind() nladdr value is a bitmask of groups, not a single group number,
it was done for backward compatibility, so bind(5) is equal to
subscribe(1) and subscribe(3). That is why you saw messages without
subscription.

-- 
	Evgeniy Polyakov
