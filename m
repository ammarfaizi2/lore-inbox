Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261502AbVCDOZP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261502AbVCDOZP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 09:25:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262929AbVCDOZP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 09:25:15 -0500
Received: from [209.203.41.250] ([209.203.41.250]:47832 "EHLO
	bventer01.shoden.co.za") by vger.kernel.org with ESMTP
	id S261502AbVCDOWj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 09:22:39 -0500
Message-ID: <42286F2B.3030500@shoden.co.za>
Date: Fri, 04 Mar 2005 16:22:35 +0200
From: Bennie Kahler-Venter <bennie.venter@shoden.co.za>
Reply-To: bennie.venter@shoden.co.za
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dtor_core@ameritech.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: v.2.6.11 mouse still losing sync and thus jumping around
References: <42271D31.8060006@shoden.co.za> <200503031543.53065.dtor_core@ameritech.net> <422822DA.2050501@shoden.co.za>
In-Reply-To: <422822DA.2050501@shoden.co.za>
Content-Type: multipart/mixed;
 boundary="------------010800030003000207020200"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010800030003000207020200
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Oops - made a small mistake - new patch

Find attached the updated psmouse-resend patch for 2.6.11.

It fixes most of the lost-sync problems for the ps2 mouse but not all of
them.  I might have picked the wrong struct members for v.2.6.11

Tnx & Bi
Bennie Kahler-Venter



--------------010800030003000207020200
Content-Type: application/x-gunzip;
 name="psmouse-resend-2_6_11-v2.patch.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="psmouse-resend-2_6_11-v2.patch.gz"

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
--------------010800030003000207020200--
