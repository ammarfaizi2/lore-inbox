Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265255AbUBIWk5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 17:40:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265232AbUBIWk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 17:40:57 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:43704 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S265215AbUBIWkz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 17:40:55 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Thomas Horsten <thomas@horsten.com>
Date: Tue, 10 Feb 2004 09:39:10 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16424.3086.469482.77925@notabene.cse.unsw.edu.au>
Cc: Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org,
       <linux-raid@vger.kernel.org>
Subject: Re: New mailing list for 2.6 Medley RAID (Silicon Image 3112 etc.)
 BIOS RAID development
In-Reply-To: message from Thomas Horsten on Monday February 9
References: <20040209121144.GA24503@devserv.devel.redhat.com>
	<Pine.LNX.4.40.0402091220130.8715-100000@jehova.dsm.dk>
X-Mailer: VM 7.18 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday February 9, thomas@horsten.com wrote:
> The only thing I don't like about this solution is that we are relying on
> both the md and dm framework. I can't see an easy way around this, since
> we need to parse the partition table on the RAID. If we just create a
> separate md device for each partition, the user won't be able to change
> the partition table.

2.6.3-rc1-mm1 supports partitioning of md arrays though a new major
number.  I'm hopeful that this will get into 2.6.4 at least.

NeilBrown
