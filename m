Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262086AbULQRkI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262086AbULQRkI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 12:40:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262088AbULQRkI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 12:40:08 -0500
Received: from mail01.hpce.nec.com ([193.141.139.228]:18865 "EHLO
	mail01.hpce.nec.com") by vger.kernel.org with ESMTP id S262086AbULQRkA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 12:40:00 -0500
From: Erich Focht <efocht@hpce.nec.com>
To: lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] [RFC] fork historic module
Date: Fri, 17 Dec 2004 18:39:07 +0100
User-Agent: KMail/1.6.2
Cc: Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       elsa-announce <elsa-announce@lists.sourceforge.net>,
       elsa-devel <elsa-devel@lists.sourceforge.net>,
       Gerrit Huizenga <gh@us.ibm.com>,
       Jean Pierre Dion <jean-pierre.dion@bull.net>,
       "lse-tech@lists.sourceforge.net" <lse-tech@lists.sourceforge.net>
References: <1103295512.7329.75.camel@frecb000711.frec.bull.fr>
In-Reply-To: <1103295512.7329.75.camel@frecb000711.frec.bull.fr>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200412171839.07927.efocht@hpce.nec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 17 December 2004 15:58, Guillaume Thouvenin wrote:
>   Here is the fork historic module. This module keeps the historic about
> the creation of processes and it gives this information to a user space
> application if one is registered. Currently, only one application can
> use it. If needed it could be extended to several applications.

This sounds very useful for a lot of interesting stuff. Though in the
current form maybe the name is not appropriate: the module doesn't
keep track of the fork history, this would be done in user-space. The
module is more like a relay for fork monitoring.

If you plan to extend this to multiple registered user space processes
it would be great to have per process reporting policies, for example:
 - all forks,
 - only forks of descendants (children, etc).

Erich

