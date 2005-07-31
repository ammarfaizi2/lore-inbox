Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261852AbVGaI0W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261852AbVGaI0W (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 04:26:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261845AbVGaI0W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 04:26:22 -0400
Received: from 238-071.adsl.pool.ew.hu ([193.226.238.71]:54543 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261840AbVGaI0U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 04:26:20 -0400
To: linuxram@us.ibm.com
CC: akpm@osdl.org, viro@parcelfarce.linux.theplanet.co.uk, mathurav@us.ibm.com,
       mike@waychison.com, janak@us.ibm.com, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-reply-to: <E1Dz8cx-0003AH-00@dorka.pomaz.szeredi.hu> (message from Miklos
	Szeredi on Sun, 31 Jul 2005 09:52:55 +0200)
Subject: Re: [PATCH 1/7] shared subtree
References: <20050725224417.501066000@localhost>
	 <20050725225907.007405000@localhost>
	 <E1DxrzJ-0001uo-00@dorka.pomaz.szeredi.hu>
	 <1122500344.5037.171.camel@localhost>
	 <E1Dy58Z-0002qL-00@dorka.pomaz.szeredi.hu>
	 <1122666893.4715.279.camel@localhost>
	 <E1Dyk4A-0006IL-00@dorka.pomaz.szeredi.hu> <1122770705.6956.23.camel@localhost> <E1Dz8cx-0003AH-00@dorka.pomaz.szeredi.hu>
Message-Id: <E1Dz98d-0003CS-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sun, 31 Jul 2005 10:25:39 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Do you still believe that your idea is simpler? 
> 
> Well, you have bundled do_make_slave(), pnode_member_to_slave() and
> empty_pnode() all into one function.  I think your original split is
> quite nice.  If you'd split this function up like that, I think you'd
> agree, that the end result is simpler.

Also you can still use the pnode concept in naming functions and
explanations.  For example empty_pnode() is a good function name even
if there's no 'struct pnode'.  Pnodes still exist, they just don't
have a corresponding object.  

Miklos
