Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266095AbSL1WZG>; Sat, 28 Dec 2002 17:25:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266100AbSL1WZG>; Sat, 28 Dec 2002 17:25:06 -0500
Received: from aslan.scsiguy.com ([63.229.232.106]:50445 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S266095AbSL1WZF>; Sat, 28 Dec 2002 17:25:05 -0500
Date: Sat, 28 Dec 2002 15:31:34 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: James Bottomley <James.Bottomley@steeleye.com>,
       Andrew Morton <akpm@digeo.com>
cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] aic7xxx bouncing over 4G 
Message-ID: <837658112.1041114694@aslan.scsiguy.com>
In-Reply-To: <200212282224.gBSMO5h03843@localhost.localdomain>
References: <200212282224.gBSMO5h03843@localhost.localdomain>
X-Mailer: Mulberry/3.0.0b9 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> gibbs@scsiguy.com said:
>> Hmm.  The only previous bug report I had in this area was related to a
>> missing cast.  That was fixed, but I guess it wasn't enough to solve
>> the problem. 
> 
> It looks like possibly a config option that doesn't exist

Yes.  It seems to only exist in 2.4.X.  I'll have to use a different
method for toggling the highmem_io option in the host structure.

--
Justin

