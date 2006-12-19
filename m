Return-Path: <linux-kernel-owner+w=401wt.eu-S932844AbWLSRMf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932844AbWLSRMf (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 12:12:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932845AbWLSRMf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 12:12:35 -0500
Received: from mx1.redhat.com ([66.187.233.31]:59862 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932844AbWLSRMe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 12:12:34 -0500
Date: Tue, 19 Dec 2006 12:11:23 -0500
From: Bill Nottingham <notting@redhat.com>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org, Diego Calleja <diegocg@gmail.com>,
       Marek Wawrzyczny <marekw1977@yahoo.com.au>
Subject: Re: GPL only modules [was Re: [GIT PATCH] more Driver core patches for 2.6.19]
Message-ID: <20061219171123.GB25507@nostromo.devel.redhat.com>
Mail-Followup-To: Gene Heskett <gene.heskett@verizon.net>,
	linux-kernel@vger.kernel.org, Diego Calleja <diegocg@gmail.com>,
	Marek Wawrzyczny <marekw1977@yahoo.com.au>
References: <MDEHLPKNGKAHNMBLJOLKCEAPAGAC.davids@webmaster.com> <200612192357.45443.marekw1977@yahoo.com.au> <20061219145627.fabf3d98.diegocg@gmail.com> <200612191146.30383.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200612191146.30383.gene.heskett@verizon.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett (gene.heskett@verizon.net) said: 
> FWIW:
> [root@coyote src]# python list-kernel-hardware.py
> Traceback (most recent call last):
>   File "list-kernel-hardware.py", line 70, in ?
>     ret = pciids_to_names(data)
>   File "list-kernel-hardware.py", line 11, in pciids_to_names
>     pciids = open('/usr/share/misc/pci.ids', 'r')
> IOError: [Errno 2] No such file or directory: '/usr/share/misc/pci.ids'
> 
> That file apparently doesn't exist on an FC6 i686 system

s/misc/hwdata/ for FC and derivatives.

Bill
