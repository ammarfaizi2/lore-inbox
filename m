Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318716AbSIFP2z>; Fri, 6 Sep 2002 11:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318717AbSIFP2z>; Fri, 6 Sep 2002 11:28:55 -0400
Received: from ns.censoft.com ([208.219.23.2]:36249 "EHLO ns.censoft.com")
	by vger.kernel.org with ESMTP id <S318716AbSIFP2y>;
	Fri, 6 Sep 2002 11:28:54 -0400
Date: Fri, 6 Sep 2002 09:27:05 -0600
From: Jordan Crouse <jordanc@censoft.com>
To: Theewara Vorakosit <g4465018@pirun.ku.ac.th>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VIA82cxxx sound problem
Message-Id: <20020906092705.7a746d39.jordanc@censoft.com>
In-Reply-To: <Pine.GSO.4.44.0209061822580.1094-100000@pirun.ku.ac.th>
References: <Pine.GSO.4.44.0209061822580.1094-100000@pirun.ku.ac.th>
Organization: Century Software
X-Mailer: Sylpheed version 0.8.2claws (GTK+ 1.2.10; )
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Dear All,
> 	I use Gigabyte GA-7VTXE+, equip with on board sound card. When I
> use sound card (when start KDE), there is a lot of message:
> 
> via82cxxx warning: SG stopped or paused
> 
> I'm using kernel 2.4.18-3, Red Hat 7.3. Would you please tell me how to solve this problem?

You motherboard has a VA8233A south bridge, which is more fully supported in 2.4.19 than in the Red Hat kernel.  Upgrade, and your problems should go away (or at least, get easier to debug).

Jordan
