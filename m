Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030302AbWJJUfc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030302AbWJJUfc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 16:35:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030305AbWJJUfc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 16:35:32 -0400
Received: from agminet01.oracle.com ([141.146.126.228]:45019 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1030302AbWJJUfb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 16:35:31 -0400
Date: Tue, 10 Oct 2006 13:35:11 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Chandra Seetharaman <sekharan@us.ibm.com>
Cc: akpm@osdl.org, ckrm-tech@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] Allow more than PAGESIZE data read in configfs
Message-ID: <20061010203511.GF7911@ca-server1.us.oracle.com>
Mail-Followup-To: Chandra Seetharaman <sekharan@us.ibm.com>, akpm@osdl.org,
	ckrm-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20061010182043.20990.83892.sendpatchset@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20061010182043.20990.83892.sendpatchset@localhost.localdomain>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2006 at 11:20:43AM -0700, Chandra Seetharaman wrote:
> Currently, maximum amount of data that can be read from a configfs
> attribute file is limited to PAGESIZE bytes. This is a limitation for
> some of the usages of configfs.

	NAK.  This forces a complex and inappropriate interface on the
majority of users, and doesn't honor configfs' simplicity-first design.
	I understand Chandra's concerns, but this patch isn't the right
way to do it.

Joel

-- 

Dort wo man Bücher verbrennt, verbrennt man am Ende auch Mensch.
(Wherever they burn books, they will also end up burning people.)
	- Heinrich Heine

Joel Becker
Principal Software Developer
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
