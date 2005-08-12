Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751210AbVHLQBF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210AbVHLQBF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 12:01:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbVHLQBE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 12:01:04 -0400
Received: from mx1.redhat.com ([66.187.233.31]:37286 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751210AbVHLQBB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 12:01:01 -0400
Date: Fri, 12 Aug 2005 12:00:46 -0400
From: Dave Jones <davej@redhat.com>
To: Andi Kleen <ak@suse.de>
Cc: Olaf Hering <olh@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel spams syslog every 10 sec with w1 debug
Message-ID: <20050812160046.GA13749@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Andi Kleen <ak@suse.de>,
	Olaf Hering <olh@suse.de>, linux-kernel@vger.kernel.org
References: <20050812150748.GA6774@suse.de.suse.lists.linux.kernel> <p73fytf2miq.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73fytf2miq.fsf@verdi.suse.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 12, 2005 at 05:38:37PM +0200, Andi Kleen wrote:
 > Olaf Hering <olh@suse.de> writes:
 > 
 > > Bug 104020 - kernel spams syslog every 10 sec with: w1_driver w1_bus_master1: No devices present on the wire.
 > > 
 > > After installing 10.0 B1, I found this in my syslog: 
 > > Aug 10 23:40:06 linux kernel: w1_driver w1_bus_master1: No devices present on the wire. 
 > > Aug 10 23:40:16 linux kernel: w1_driver w1_bus_master1: No devices present on the wire. 
 > 
 > More interesting is why this thing is running at all.
 > It shouldn't. 

Doesnt that get loaded if there's a Matrox card present ?
(I am completely guessing here, so could be way off base).

		Dave

