Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261460AbTISJps (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 05:45:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261463AbTISJpr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 05:45:47 -0400
Received: from main.gmane.org ([80.91.224.249]:47745 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261460AbTISJpr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 05:45:47 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Resuming from software suspend [was: Re: How does one get paid to
 work on the kernel?]
Date: Fri, 19 Sep 2003 11:45:09 +0200
Message-ID: <yw1xwuc5kt7e.fsf_-_@users.sourceforge.net>
References: <1063915370.2410.12.camel@laptop-linux> <yw1xad91nrmd.fsf@users.sourceforge.net>
 <1063958370.5520.6.camel@laptop-linux>
 <yw1xu179mc55.fsf@users.sourceforge.net>
 <1063963914.7253.9.camel@laptop-linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:izfjX9i0jxzOvTG09VHW8uIpA+g=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Cunningham <ncunningham@clear.net.nz> writes:

> Yes, provided as you say that you don't mount the file systems involved;
> mounting them will make journalling filesystems run their recoveries,
> which will in turn make the suspend image inconsistent. It's only really
> viable if the filesystems were mounted read only to start with... I've
> just added functionality to the 2.4 version for such a case.

OK, is it possible with 2.6?  The Kconfig help says you can.  How is
it done?

-- 
Måns Rullgård
mru@users.sf.net

