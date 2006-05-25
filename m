Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030503AbWEYWwY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030503AbWEYWwY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 18:52:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030504AbWEYWwX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 18:52:23 -0400
Received: from dspnet.fr.eu.org ([213.186.44.138]:33543 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S1030503AbWEYWwX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 18:52:23 -0400
Date: Fri, 26 May 2006 00:52:22 +0200
From: Olivier Galibert <galibert@pobox.com>
To: linux-kernel@vger.kernel.org
Cc: Dave Jones <davej@redhat.com>, Jeff Garzik <jeff@garzik.org>
Subject: Re: How to check if kernel sources are installed on a system?
Message-ID: <20060525225222.GA14552@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	linux-kernel@vger.kernel.org, Dave Jones <davej@redhat.com>,
	Jeff Garzik <jeff@garzik.org>
References: <e55715+usls@eGroups.com> <447622EA.90704@garzik.org> <20060525213952.GT13513@lug-owl.de> <20060525214413.GE4328@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060525214413.GE4328@redhat.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2006 at 05:44:13PM -0400, Dave Jones wrote:
> Following /lib/modules/`uname -r`/build is the only way this can work.
> (And that should be true on any distro)

On one side it's a reasonably nice way, on the other it makes it hard
to build modules for a different kernel than the running one.  I have
a uname version in a corner that allows overriding the -r return with
an environment variable just for that reason, I should probably send
the path upstream.

  OG.

