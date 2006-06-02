Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932296AbWFBPKT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932296AbWFBPKT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 11:10:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932216AbWFBPKT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 11:10:19 -0400
Received: from gw.openss7.com ([142.179.199.224]:1732 "EHLO gw.openss7.com")
	by vger.kernel.org with ESMTP id S932158AbWFBPKR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 11:10:17 -0400
Date: Fri, 2 Jun 2006 09:10:15 -0600
From: "Brian F. G. Bidulock" <bidulock@openss7.org>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: Florian Weimer <fw@deneb.enyo.de>, David Miller <davem@davemloft.net>,
       draghuram@rocketmail.com, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: Question about tcp hash function tcp_hashfn()
Message-ID: <20060602091015.C18533@openss7.org>
Reply-To: bidulock@openss7.org
Mail-Followup-To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
	Florian Weimer <fw@deneb.enyo.de>,
	David Miller <davem@davemloft.net>, draghuram@rocketmail.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20060531090301.GA26782@2ka.mipt.ru> <20060531035124.B3065@openss7.org> <20060531105814.GB7806@2ka.mipt.ru> <20060531.114127.14356069.davem@davemloft.net> <20060601060424.GA28087@2ka.mipt.ru> <87y7wgaze1.fsf@mid.deneb.enyo.de> <20060602074845.GA17798@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20060602074845.GA17798@2ka.mipt.ru>; from johnpol@2ka.mipt.ru on Fri, Jun 02, 2006 at 11:48:46AM +0400
Organization: http://www.openss7.org/
Dsn-Notification-To: <bidulock@openss7.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy,

I agree, even with constant source IP, the hash still should have
performed better (but didn't).  Constant source IP and varying
port is a realistic data set for a port proxy.
