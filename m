Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265974AbUG1WQ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265974AbUG1WQ4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 18:16:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265893AbUG1WQz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 18:16:55 -0400
Received: from mx1.redhat.com ([66.187.233.31]:57304 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265974AbUG1WQj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 18:16:39 -0400
Date: Wed, 28 Jul 2004 18:15:54 -0400
From: Alan Cox <alan@redhat.com>
To: Ben Greear <greearb@candelatech.com>
Cc: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: PATCH: VLAN support for 3c59x/3c90x
Message-ID: <20040728221554.GA22747@devserv.devel.redhat.com>
References: <20040728124256.GA31246@devserv.devel.redhat.com> <41081BC4.6040607@candelatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41081BC4.6040607@candelatech.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2004 at 02:33:56PM -0700, Ben Greear wrote:
> >Stefan de Konink ported this code from the 2.4 VLAN patches and tested it
> >extensively. I cleaned up the ifdefs and fixed a problem with bracketing
> >that made older cards fail.
> 
> I am sure this will be appreciated by the VLAN users!
> 
> Also, do you happen to know how large of an MTU these cards
> can support?

In VLAN mode they support just the extra VLAN bits, with the length
checking turned off its either FDDI or jumbo frame size but I don't remember
which. I think FDDI.


