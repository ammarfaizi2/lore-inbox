Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262329AbUIOAsZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262329AbUIOAsZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 20:48:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265977AbUIOAsZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 20:48:25 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:50926 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262329AbUIOAsY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 20:48:24 -0400
Date: Tue, 14 Sep 2004 17:47:22 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Anton Blanchard <anton@samba.org>,
       Chris Friesen <cfriesen@nortelnetworks.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>, paulus@samba.org
Subject: Re: offtopic: how to break huge patch into smaller independent patches?
Message-ID: <119340000.1095209242@flay>
In-Reply-To: <20040915002023.GD5615@krispykreme>
References: <41474B15.8040302@nortelnetworks.com> <20040915002023.GD5615@krispykreme>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Its kind of offtopic, but I hoped that someone might have some pointers 
>> since the kernel developers deal with so many patches.
>> 
>> I've been given a massive kernel patch that makes a whole bunch of 
>> conceptually independent changes.
>> 
>> Does anyone have any advice on how to break it up into independent patches?
> 
> dirdiff is a great tool for this. I think its on samba.org somewhere,
> but you can definitely find it in debian.
> 
> The new version is even better, I think Paul should do a release :)

If the changes are in fairly independant files, just vi'ing the diff is
normally very effective. If they're all intertangled, then starting again
from scratch is prob easier ;-)

M.

