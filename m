Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750934AbVHHPJ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750934AbVHHPJ6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 11:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750938AbVHHPJ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 11:09:57 -0400
Received: from no-dns-yet.demon.co.uk ([195.173.84.2]:30736 "EHLO
	monitor.bluefinger.com") by vger.kernel.org with ESMTP
	id S1750928AbVHHPJ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 11:09:57 -0400
From: Thomas Chiverton <thomas.chiverton@bluefinger.com>
To: Mathieu Chouquet-Stringer <ml2news@optonline.net>
Subject: Re: cifs kernel module and MS DFS shares [2.6.12-1.1411_FC4]
Date: Mon, 8 Aug 2005 16:09:53 +0100
Cc: linux-kernel@vger.kernel.org
References: <200508081526.55555@moveAlongNothingToSeeHere> <m3pssobhon.fsf@mcs.bigip.mine.nu>
In-Reply-To: <m3pssobhon.fsf@mcs.bigip.mine.nu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508081609.53943@moveAlongNothingToSeeHere>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 08 August 2005 15:56, Mathieu Chouquet-Stringer wrote:
> I've got the same issue but if I go down 2 or 3 levels, it works (ie

Well, *something* changes after 3 levels:

 ls /mnt/dfs/Consultants/
Applications  Consultants  Engineering  Management            Version
Common        Directors    Finance      Software Development  WinTA Data

 ls /mnt/dfs/Consultants/Consultants/
Applications  Consultants  Engineering  Management            Version
Common        Directors    Finance      Software Development  WinTA Data

 ls /mnt/dfs/Consultants/Consultants/Consultants/
ls: reading directory /mnt/dfs/Consultants/Consultants/Consultants/: Object is 
remote

-- 

Tom Chiverton 
Advanced ColdFusion Programmer
