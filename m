Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261752AbVANBOO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261752AbVANBOO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 20:14:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261852AbVANBN4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 20:13:56 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:53161 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S261752AbVANBMI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 20:12:08 -0500
Date: Thu, 13 Jan 2005 20:11:59 -0500
Message-Id: <200501140111.j0E1Bx0N023763@agora.fsl.cs.sunysb.edu>
From: Erez Zadok <ezk@cs.sunysb.edu>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] shared subtrees 
In-reply-to: Your message of "Thu, 13 Jan 2005 22:18:51 GMT."
             <20050113221851.GI26051@parcelfarce.linux.theplanet.co.uk> 
X-MailKey: Erez_Zadok
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al, how do shared subtrees related to stacking?  From your description, it
looks like event propagation is similar to what stacking does (pass an op
from one layer to another), only that subtree sharing is for "mount points"
and not for every VFS object.  Am I right?

If shared subtrees have nothing to do with stacking, do you foresee them as
perhaps a first step toward full stacking support in the VFS?  (I mean, if
we're going to have to hack the VFS heavily already...)  Your "p-node"
sounds awfully similar to Rosenthal's and Skinner's "pvnode"s. :-)

Thanks,
Erez.
