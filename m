Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030480AbVKPUKr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030480AbVKPUKr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 15:10:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030485AbVKPUKr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 15:10:47 -0500
Received: from 90.Red-213-97-199.staticIP.rima-tde.net ([213.97.199.90]:7211
	"HELO fargo") by vger.kernel.org with SMTP id S1030480AbVKPUKq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 15:10:46 -0500
Date: Wed, 16 Nov 2005 21:10:20 +0100
From: David =?utf-8?B?R8OzbWV6?= <david@pleyades.net>
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: /net/sched/Kconfig broken
Message-ID: <20051116201020.GA15113@fargo>
Mail-Followup-To: "David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org
References: <20051116194414.GA14953@fargo> <20051116.115141.33136176.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20051116.115141.33136176.davem@davemloft.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Nov 16 at 11:51:41, David S. Miller wrote:
> From: David Gómez <david@pleyades.net>
> Date: Wed, 16 Nov 2005 20:44:14 +0100
> 
> > It's impossible to enable the U32 classifier in QoS submenu, to use it
> > with the "tc" application. In fact there are 23 :-/ options and suboptions
> > that are missing from the configuration because it seems that the Kconfig
> > file is broken.
> 
> I can enable this just fine by using "make config", making
> sure to enable CONFIG_NET_SCHED, then CONFIG_NET_CLS_BASIC,
> and then the necessary classifiers (including U32) are offered
> to be enabled.

Sorry for not giving more details. I'm using make menuconfig
in a 2.6.14 kernel After selecting CONFIG_NET_SCHED and CONFIG_NET_CLS_BASIC
i don't see new options, the last option visible is NET_CLS_ROUTE4.

thanks,

-- 
David Gómez                                      Jabber ID: davidge@jabber.org
