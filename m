Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751350AbVKIJZ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751350AbVKIJZ5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 04:25:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751351AbVKIJZ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 04:25:57 -0500
Received: from ns.firmix.at ([62.141.48.66]:39362 "EHLO ns.firmix.at")
	by vger.kernel.org with ESMTP id S1751350AbVKIJZ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 04:25:57 -0500
Subject: Re: typedefs and structs
From: Bernd Petrovitsch <bernd@firmix.at>
To: linas <linas@austin.ibm.com>
Cc: Zan Lynx <zlynx@acm.org>, David Gibson <dwg@au1.ibm.com>,
       Steven Rostedt <rostedt@goodmis.org>, linuxppc64-dev@ozlabs.org,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       bluesmoke-devel@lists.sourceforge.net
In-Reply-To: <20051109004247.GL19593@austin.ibm.com>
References: <20051107182727.GD18861@kroah.com>
	 <20051107185621.GD19593@austin.ibm.com> <20051107190245.GA19707@kroah.com>
	 <20051107193600.GE19593@austin.ibm.com> <20051107200257.GA22524@kroah.com>
	 <20051107204136.GG19593@austin.ibm.com>
	 <1131412273.14381.142.camel@localhost.localdomain>
	 <20051108232327.GA19593@austin.ibm.com>
	 <20051108235759.GA28271@localhost.localdomain>
	 <1131495228.12797.67.camel@localhost>
	 <20051109004247.GL19593@austin.ibm.com>
Content-Type: text/plain
Organization: Firmix Software GmbH
Date: Wed, 09 Nov 2005 10:25:20 +0100
Message-Id: <1131528320.19171.17.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-08 at 18:42 -0600, linas wrote:
[ C vs C++ ]
> It fundamentally changes coding style; you'd have to try it on some 
> mid-size project for at least a few months or longer to get into the
> mindset.  To make it all work, you also have to do other things, like 
> avoid mallocs and allocing on stack, which forces major changes of 
> style (because of the lifetime of things on stack). If you don't change 

The lifetime of the stack is AFAIK the same on C and C++. So there can't
be a significant difference.

> style to go with it, then you'll just end up in debug hell, in which
> case you'd be right: it would be a (very) bad idea.
> 
> (Disclaimer: I've moved away from C++ because of all the other
> opportunities for misuse that it offers and encourages.)

You that opportunities in all programming languages - in some more (perl
being probably the leader here), in some less (I don't know one).

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

