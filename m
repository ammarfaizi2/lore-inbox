Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263452AbTLDSbs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 13:31:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263785AbTLDSbq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 13:31:46 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:1706 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263452AbTLDSaH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 13:30:07 -0500
Date: Thu, 04 Dec 2003 10:29:53 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Jesse Barnes <jbarnes@sgi.com>, IWAMOTO Toshihiro <iwamoto@valinux.co.jp>
cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: memory hotremove prototype, take 3
Message-ID: <14880000.1070562593@flay>
In-Reply-To: <20031204182729.GA7965@sgi.com>
References: <20031201034155.11B387007A@sv1.valinux.co.jp> <187360000.1070480461@flay> <20031204035842.72C9A7007A@sv1.valinux.co.jp> <152440000.1070516333@10.10.2.4> <20031204154406.7FC587007A@sv1.valinux.co.jp> <20031204182729.GA7965@sgi.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> IIRC, memory is contiguous within a NUMA node.  I think Goto-san will
>> clarify this issue when his code gets ready. :-)
> 
> Not on all systems.  On sn2 we use ia64's virtual memmap to make memory
> within a node appear contiguous, even though it may not be.

Wasn't there a plan to get rid of that though? I forget what it was,
probably using CONFIG_NONLINEAR too ... ?

M.

