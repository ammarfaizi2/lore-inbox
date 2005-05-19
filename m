Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261278AbVESVtU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261278AbVESVtU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 17:49:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261277AbVESVtU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 17:49:20 -0400
Received: from chaos.egr.duke.edu ([152.3.195.82]:19077 "EHLO
	chaos.egr.duke.edu") by vger.kernel.org with ESMTP id S261278AbVESVso
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 17:48:44 -0400
Date: Thu, 19 May 2005 17:48:36 -0400 (EDT)
From: Joshua Baker-LePain <jlb17@duke.edu>
X-X-Sender: jlb@chaos.egr.duke.edu
To: Gregory Brauer <greg@wildbrain.com>
cc: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com,
       Jakob Oestergaard <jakob@unthought.net>, Chris Wedgwood <cw@f00f.org>
Subject: Re: kernel OOPS for XFS in xfs_iget_core (using NFS+SMP+MD)
In-Reply-To: <Pine.LNX.4.58.0505191740550.7094@chaos.egr.duke.edu>
Message-ID: <Pine.LNX.4.58.0505191746470.7094@chaos.egr.duke.edu>
References: <428511F8.6020303@wildbrain.com> <20050514184711.GA27565@taniwha.stupidest.org>
 <428B7D7F.9000107@wildbrain.com> <20050518175925.GA22738@taniwha.stupidest.org>
 <20050518195251.GY422@unthought.net> <Pine.LNX.4.58.0505181556410.6834@chaos.egr.duke.edu>
 <428BA8E4.2040108@wildbrain.com> <Pine.LNX.4.58.0505191537560.7094@chaos.egr.duke.edu>
 <Pine.LNX.4.58.0505191650580.7094@chaos.egr.duke.edu>
 <Pine.LNX.4.58.0505191740550.7094@chaos.egr.duke.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 May 2005 at 5:42pm, Joshua Baker-LePain wrote

> And now I've got some OOPSes:

But, looking at 'em (instead of just blindly sending 'em along), I don't 
see XFS anywhere in them.  The "interesting" thing is that, of the 
nfs_fsstress logs in /tmp on all the clients, only the NFSv3 over TCP log 
is showing errors on any of the clients.

-- 
Joshua Baker-LePain
Department of Biomedical Engineering
Duke University
