Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422818AbWJLIWT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422818AbWJLIWT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 04:22:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422819AbWJLIWS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 04:22:18 -0400
Received: from ozlabs.org ([203.10.76.45]:61333 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1422818AbWJLIWR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 04:22:17 -0400
Date: Thu, 12 Oct 2006 18:22:14 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Santiago Leon <santil@us.ibm.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org
Subject: veth crash (commit 751ae21c6cd1493e3d0a4935b08fb298b9d89773)
Message-ID: <20061012082214.GA9154@localhost.localdomain>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Santiago Leon <santil@us.ibm.com>, Jeff Garzik <jeff@garzik.org>,
	linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Your recent ibmveth commit, 751ae21c6cd1493e3d0a4935b08fb298b9d89773
("fix int rollover panic"), causes a rapid oops on my test machine
(POWER5 LPAR).

I've bisected it down to that commit, but am still investigating the
cause of the crash itself.


-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
