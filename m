Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261981AbUC1QnY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 11:43:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261988AbUC1QnY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 11:43:24 -0500
Received: from gizmo10bw.bigpond.com ([144.140.70.20]:19426 "HELO
	gizmo10bw.bigpond.com") by vger.kernel.org with SMTP
	id S261981AbUC1QnW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 11:43:22 -0500
From: Ross Dickson <ross@datscreative.com.au>
Reply-To: ross@datscreative.com.au
Organization: Dat's Creative Pty Ltd
To: preining@logic.at
Subject: Re: md raid oops on 2.4.25/alpha   
Date: Mon, 29 Mar 2004 02:45:51 +1000
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403290245.51813.ross@datscreative.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Norbert Preining wrote

> Hi Ingo, hi Neil, hi lists! 

> We have some problems with the md code on alpha. We get regular oops 
>  when using the md raid1. Here we got another oops when fsck (at boot 
>  time) the raid: 
>  This was after a fresh reboot. As long as only the raid is *not* mounted 
>  of fsck the machine works without any oops. 
 
Please clarify symptoms regarding fsck at boot and Oops. Are they like mine?

Symptoms I have had with a compact flash boot hda (ide) are that
clean boot with fsck doing nothing is OK no Oops.

If fsck corrects anything and boot continues then Oops will occur. That is I
need to reboot machine after fsck rc=1 or I get Oops.

Regards
Ross.

> I also can mount the hard disks *without* raid directly as hda1 and 
>  hdc1, and do NOT get any errors here, so I suspect that only the md code 
>  is the culprit. 

> Please tell me how I can track down this problem, how I can help you! 
 
