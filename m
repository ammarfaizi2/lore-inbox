Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751270AbVJST6p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751270AbVJST6p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 15:58:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbVJST6p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 15:58:45 -0400
Received: from sccrmhc11.comcast.net ([63.240.77.81]:26769 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1751265AbVJST6o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 15:58:44 -0400
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Daniel Drake <dsd@gentoo.org>
Subject: Re: [PATCH] skge support for Marvell chips in Toshiba laptops
Date: Wed, 19 Oct 2005 12:58:30 -0700
User-Agent: KMail/1.8.91
Cc: shemminger@osdl.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <200510191047.53212.jbarnes@virtuousgeek.org> <4356A1F5.5010200@gentoo.org>
In-Reply-To: <4356A1F5.5010200@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510191258.31316.jbarnes@virtuousgeek.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, October 19, 2005 12:43 pm, Daniel Drake wrote:
> The device ID you added (0x4351) is already claimed by the new sky2
> driver.
>
> Unless theres a mistake in sky2's device table, your laptop contains a
> Yukon-II adapter which is incompatible with the original Yukon chips
> (skge = Yukon, sky2 = Yukon-II).
>
> On the other hand, I believe Stephen could do with some extra sky2
> testing :) You can find it in the latest -mm releases.

Oh cool, I'll try that driver instead.  Thanks.

Jesse
