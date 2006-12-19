Return-Path: <linux-kernel-owner+w=401wt.eu-S932848AbWLSRMt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932848AbWLSRMt (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 12:12:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932845AbWLSRMt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 12:12:49 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:58402 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932848AbWLSRMs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 12:12:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=WV7v3SzRq+ftJVj52ET7A7oD6QusnALFHjlxXspSnQwWM6mVSdxdmEy80lrZ7YrGKoND+AmZrmzyYy+F894EeNpXKft4oI1xuX1TSSOLEtjUoXKZxEHnm7Pk74nt5eL2PagVz/Uxt1hpLycuN2DB836Nw6uauoFOPMjSgCPO51U=
Date: Tue, 19 Dec 2006 18:13:21 +0100
From: Diego Calleja <diegocg@gmail.com>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org, Marek Wawrzyczny <marekw1977@yahoo.com.au>
Subject: Re: GPL only modules [was Re: [GIT PATCH] more Driver core patches
 for 2.6.19]
Message-Id: <20061219181321.963e8299.diegocg@gmail.com>
In-Reply-To: <200612191146.30383.gene.heskett@verizon.net>
References: <MDEHLPKNGKAHNMBLJOLKCEAPAGAC.davids@webmaster.com>
	<200612192357.45443.marekw1977@yahoo.com.au>
	<20061219145627.fabf3d98.diegocg@gmail.com>
	<200612191146.30383.gene.heskett@verizon.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.10.6; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Tue, 19 Dec 2006 11:46:30 -0500, Gene Heskett <gene.heskett@verizon.net> escribió:

> IOError: [Errno 2] No such file or directory: '/usr/share/misc/pci.ids'
> 
> That file apparently doesn't exist on an FC6 i686 system

Indeed, I forgot to document that. Ubuntu has it there (package pciutils), and
update-pciids updates the file from http://pciids.sourceforge.net/pci.ids. So you
can download that file and change the path in the script.

Anyway, you can find the output at http://www.terra.es/personal/diegocg/list.txt
