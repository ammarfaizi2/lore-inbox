Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261489AbTISLKR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 07:10:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261507AbTISLKR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 07:10:17 -0400
Received: from main.gmane.org ([80.91.224.249]:23940 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261489AbTISLKO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 07:10:14 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: Resuming from software suspend
Date: Fri, 19 Sep 2003 13:09:36 +0200
Message-ID: <yw1xfzitkpan.fsf@users.sourceforge.net>
References: <1063915370.2410.12.camel@laptop-linux> <yw1xad91nrmd.fsf@users.sourceforge.net>
 <1063958370.5520.6.camel@laptop-linux>
 <yw1xu179mc55.fsf@users.sourceforge.net>
 <1063963914.7253.9.camel@laptop-linux>
 <yw1xwuc5kt7e.fsf_-_@users.sourceforge.net>
 <1063965939.7874.6.camel@laptop-linux>
 <yw1xoexhkrtb.fsf@users.sourceforge.net>
 <1063967259.7874.14.camel@laptop-linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:1IJPFMJMmHjV+4T8eACaYNzW7jY=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Cunningham <ncunningham@clear.net.nz> writes:

> Provided you're not making the data of the filesystem inconsistent with
> the state that the suspended image is expecting to see, you won't get
> any corruption. As to beginning a resume without rebooting, whether it
> would work would depend upon the size of the image, the amount of memory
> used when you start the resume and the degree of overlap between the two
> sets of memory.

If all processes are killed and all filesystem unmounted, there's not
much left to use memory.  Once you've decided to resume, there's not
much point in keeping old processes running, is there?

-- 
Måns Rullgård
mru@users.sf.net

