Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264476AbTFEDXK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 23:23:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264477AbTFEDXJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 23:23:09 -0400
Received: from holomorphy.com ([66.224.33.161]:11701 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264476AbTFEDXG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 23:23:06 -0400
Date: Wed, 4 Jun 2003 20:35:32 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Albert Cahalan <albert@users.sf.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, davem@redhat.com,
       torvalds@transmeta.com, bcollins@debian.org, tom_gall@vnet.ibm.com,
       anton@samba.org
Subject: Re: /proc/bus/pci
Message-ID: <20030605033532.GY8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Albert Cahalan <albert@users.sf.net>,
	linux-kernel <linux-kernel@vger.kernel.org>, davem@redhat.com,
	torvalds@transmeta.com, bcollins@debian.org, tom_gall@vnet.ibm.com,
	anton@samba.org
References: <1054783303.22104.5569.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1054783303.22104.5569.camel@cube>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 04, 2003 at 11:21:43PM -0400, Albert Cahalan wrote:
> I notice that /proc/bus/pci doesn't offer a sane
> interface for multiple PCI domains and choice of BAR.
> What do people think of this?
> bus/pci/00/00.0 -> ../hose0/bus0/dev0/fn0/config-space
> bus/pci/hose0/bus0/dev0/fn0/config-space
> bus/pci/hose0/bus0/dev0/fn0/bar0
> bus/pci/hose0/bus0/dev0/fn0/bar1
> bus/pci/hose0/bus0/dev0/fn0/bar2
> bus/pci/hose0/bus0/dev0/fn0/status

I would be happy with such an interface.


-- wli
