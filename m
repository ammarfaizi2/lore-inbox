Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265684AbUGZPIH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265684AbUGZPIH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 11:08:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265697AbUGZPIG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 11:08:06 -0400
Received: from peabody.ximian.com ([130.57.169.10]:58268 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S265684AbUGZOuH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 10:50:07 -0400
Subject: RE: [patch] kernel events layer
From: Robert Love <rml@ximian.com>
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, cw@f00f.org, linux-kernel@vger.kernel.org
In-Reply-To: <F989B1573A3A644BAB3920FBECA4D25A6EBFB5@orsmsx407>
References: <F989B1573A3A644BAB3920FBECA4D25A6EBFB5@orsmsx407>
Content-Type: text/plain
Date: Mon, 26 Jul 2004 10:50:03 -0400
Message-Id: <1090853403.1973.11.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.90 (1.5.90-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-07-26 at 00:31 -0700, Perez-Gonzalez, Inaky wrote:

> methinks: if the message is related to some object that has a kobject
> representation, use it. If not, come up with one on a case by case
> basis [now this is the difficult one--is where it'd be difficult to
> keep things on leash].

That introduces two orthogonal name spaces, and that really doesn't cut
it.

If Greg can come up with a solution for using kobjects, I am all for
that - that would be great - but I really do not see kobject paths
working out.  I think the best we have is the file path in the tree.

	Robert Love


