Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265376AbUFBXd2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265376AbUFBXd2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 19:33:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265383AbUFBXd2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 19:33:28 -0400
Received: from mail018.syd.optusnet.com.au ([211.29.132.72]:59336 "EHLO
	mail018.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S265376AbUFBXdZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 19:33:25 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Bill Davidsen <davidsen@tmr.com>
Subject: Re: swappiness ignored
Date: Thu, 3 Jun 2004 09:33:15 +1000
User-Agent: KMail/1.6.1
Cc: linux-kernel@vger.kernel.org
References: <40B43B5F.8070208@nodivisions.com> <200406011136.17055@WOLK> <c9lb2n$l17$1@gatekeeper.tmr.com>
In-Reply-To: <c9lb2n$l17$1@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406030933.16320.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jun 2004 05:54, Bill Davidsen wrote:
> Marc-Christian Petersen wrote:
> > I bet you have /proc/sys/vm/autoswappiness or the previous version of it
> > w/o /proc stuff.
>
> What option do I need to enable so I can get this control (to disable
> it)? I have sysctl enabled in 2.6.7-rc1 and no autoswappiness to be found.

This only exists if you have it patched with my autoregulated swappiness 
patch. 

http://ck.kolivas.org/patches/2.6/2.6.7-rc2/patch-2.6.7-rc2-am11


The mainline kernel has a static value for swappiness you can set any time.

echo 60 > /proc/sys/vm/swappiness

Con
