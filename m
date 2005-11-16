Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030551AbVKPWsZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030551AbVKPWsZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 17:48:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030550AbVKPWsT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 17:48:19 -0500
Received: from 90.Red-213-97-199.staticIP.rima-tde.net ([213.97.199.90]:33365
	"HELO fargo") by vger.kernel.org with SMTP id S1030552AbVKPWsG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 17:48:06 -0500
Date: Wed, 16 Nov 2005 23:47:46 +0100
From: David =?utf-8?B?R8OzbWV6?= <david@pleyades.net>
To: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
Subject: Re: /net/sched/Kconfig broken
Message-ID: <20051116224746.GB8903@fargo>
Mail-Followup-To: "David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org
References: <20051116194414.GA14953@fargo> <20051116.115141.33136176.davem@davemloft.net> <20051116201020.GA15113@fargo>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20051116201020.GA15113@fargo>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Nov 16 at 09:10:20, David Gómez wrote:
> > I can enable this just fine by using "make config", making
> > sure to enable CONFIG_NET_SCHED, then CONFIG_NET_CLS_BASIC,
> > and then the necessary classifiers (including U32) are offered
> > to be enabled.
> 
> Sorry for not giving more details. I'm using make menuconfig
> in a 2.6.14 kernel After selecting CONFIG_NET_SCHED and CONFIG_NET_CLS_BASIC
> i don't see new options, the last option visible is NET_CLS_ROUTE4.

I tested 'gconfig' and i'm able to see all the options in the QoS menu,
so the problem seems 'menuconfig' related...

-- 
David Gómez                                      Jabber ID: davidge@jabber.org
