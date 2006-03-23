Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750821AbWCWNbk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750821AbWCWNbk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 08:31:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751201AbWCWNbk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 08:31:40 -0500
Received: from rtr.ca ([64.26.128.89]:53174 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1750821AbWCWNbj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 08:31:39 -0500
Message-ID: <4422A340.2080104@rtr.ca>
Date: Thu, 23 Mar 2006 08:31:44 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8) Gecko/20060305 SeaMonkey/1.1a
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.16 Regression:  vbetool:  Error: something went wrong performing
 real mode call
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As of 2.6.16, I am seeing this message when I do suspend-to-RAM
from a text window:

Error: something went wrong performing real mode call

I've narrowed it down to coming from "vbetool post"
on resume from RAM.

This is Kubuntu-5.10 Breezy, with vbetool-0.3-1.
I'll trace it further when I have the opportunity.

Resume still appears to work, but overnight suspend/resume does not
always work -- not sure if that is related to this message,
or to some USB modules.

Cheers
