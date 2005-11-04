Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750985AbVKDOkI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750985AbVKDOkI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 09:40:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751000AbVKDOkH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 09:40:07 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:16926
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1750985AbVKDOkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 09:40:06 -0500
Message-Id: <436B80F8.76F0.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Fri, 04 Nov 2005 15:40:40 +0100
From: "Jan Beulich" <JBeulich@novell.com>
To: <sam.ravnborg@ericsson.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: use of $(objtree) with certain include references
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam,

in early September, you indicated in
http://marc.theaimsgroup.com/?l=linux-kernel&m=112603854721991&w=2
that the change from Andreas Gruenbacher to use $(objtree) on certain
include references in the makefiles was already in Linus' tree. Now,
looking more closely at the changes 2.6.14 made, I find that none of
those prefixes aren't there. Thus I wonder - did you add something (that
escapes me) that makes this prefixing unnecessary, or was the patch
later dropped for some reason?

Thanks, Jan
