Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263411AbTEMU1S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 16:27:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263397AbTEMU1P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 16:27:15 -0400
Received: from main.gmane.org ([80.91.224.249]:51905 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263415AbTEMU0t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 16:26:49 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: What exactly does "supports Linux" mean?
Date: 13 May 2003 22:36:01 +0200
Message-ID: <yw1x3cjifutq.fsf@zaphod.guide>
References: <200305131114_MC3-1-38B0-3C13@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@main.gmane.org
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Portable Code)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert <76306.1226@compuserve.com> writes:

> > My general conclusion would be that something not working with a standard
> > kernel cannot be called "supporting linux", no matter what distros ever are
> > supported. You may call me purist...
> 
>   If their drivers don't come with full source code then their claims
> of supporting Linux are just a bad joke AFAIC.

Even when they do, it's often far from what I would call "Linux
support".  I've seen vendor drivers that made such assumptions about
the machine that they would only work on IA-32 machines.  I'm talking
about things like assuming that sizof(int) == sizeof(void *) == 4, or
that physical memory addresses are the same seen from the CPU and from
the PCI bus.

-- 
Måns Rullgård
mru@users.sf.net

