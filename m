Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751171AbWJHOTN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751171AbWJHOTN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 10:19:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751191AbWJHOTM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 10:19:12 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:23396 "EHLO
	asav07.insightbb.com") by vger.kernel.org with ESMTP
	id S1751171AbWJHOTM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 10:19:12 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AR4FAJCkKEWBToo2LA
From: Dmitry Torokhov <dtor@insightbb.com>
To: Roberto Nibali <ratz@drugphish.ch>
Subject: Re: possible recursive locking detected: kseriod on 2.6.19-rc1-gb0eb0838
Date: Sun, 8 Oct 2006 10:19:10 -0400
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <4528DE50.5020807@drugphish.ch>
In-Reply-To: <4528DE50.5020807@drugphish.ch>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610081019.11009.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 08 October 2006 07:17, Roberto Nibali wrote:
> Hi,
> 
> I don't know if this has been reported before, but here goes:
>

Thank you for the report. It is a false positive, we have a patch
to silence lockdep here.
  
-- 
Dmitry
