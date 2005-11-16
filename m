Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030222AbVKPJRJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030222AbVKPJRJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 04:17:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030253AbVKPJRI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 04:17:08 -0500
Received: from ns.firmix.at ([62.141.48.66]:48770 "EHLO ns.firmix.at")
	by vger.kernel.org with ESMTP id S1030222AbVKPJRG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 04:17:06 -0500
Subject: Re: [2.6 patch] i386: always use 4k stacks
From: Bernd Petrovitsch <bernd@firmix.at>
To: "Wed, 16 Nov 2005 00:41:11 +0100" <grundig@teleline.es>
Cc: Arjan van de Ven <arjan@infradead.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20051116004111.45f3f704.grundig@teleline.es>
References: <20051116004111.45f3f704.grundig@teleline.es>
Content-Type: text/plain; charset=UTF-8
Organization: Firmix Software GmbH
Date: Wed, 16 Nov 2005 10:04:14 +0100
Message-Id: <1132131854.1600.12.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-16 at 00:41 +0100, Wed, 16 Nov 2005 00:41:11 +0100
                                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
                                   Interesting Name.
wrote:
> > documentation for broadcom wireless:
> > http://bcm-specs.sipsolutions.net/
> > embrionic driver based on this spec:
> > http://bcm43xx.berlios.de/
> 
> 
> Maybe a good deal would be to delay the 4K patch until some preliminary
> version of those is merged? 

Set the default value to "4k" and - to streß it further - remove the
questions on `make *config` so that sufficiently interesting people must
edit by hand after searching for it.
This will give the correct impression for everyone where it will go,
possibly raises the awareness of this area (WLAN drivers) and it doesn't
break ATM anything seriously.

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

