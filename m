Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261780AbTIZMqF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 08:46:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261929AbTIZMqF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 08:46:05 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:61609 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S261780AbTIZMqD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 08:46:03 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: mru@users.sourceforge.net (Mons Rullgord)
Date: Fri, 26 Sep 2003 14:45:42 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: vmware in Linux 2.6
Cc: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <14D30F86678@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 Sep 03 at 12:50, Mons Rullgord wrote:
> "Petr Vandrovec" <VANDROVE@vc.cvut.cz> writes:
> 
> >> Is it possible to use vmware with Linux 2.6?  The kernel modules
> >> (obviously) fail to compile.
> >
> > Do you know Google?... And best for such type of questions are newsgroups
> > at news.vmware.com, especially one named vmware.for-linux.experimental.
> 
> I already tried google.  It only turned up a solution that involved
> editing something in the vmnet module.  In my case, the vmmon module
> failed rather miserably, and I couldn't find anything about that.

Failed rather miserably == no 'prev' member in linuxState.misc? Then
it is fixed in vmware-any-any-update40... 

And except that this patch makes thing compilable, it also makes driver 
a bit friendlier to the MM subsystem, it allows you to use VMware on 
4G/4G host, and it properly handles bridged networking on adapters using 
hardware (or pseudohardware...) Tx checksumming (although only for IPv4 
due to features of dev_queue_xmit_nit).
                                                Petr Vandrovec
                                                

