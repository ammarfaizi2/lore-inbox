Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262118AbULQSoS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262118AbULQSoS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 13:44:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262113AbULQSmm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 13:42:42 -0500
Received: from serenity.mcc.ac.uk ([130.88.200.93]:3339 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP id S261873AbULQSjY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 13:39:24 -0500
Date: Fri, 17 Dec 2004 18:39:22 +0000
From: John Levon <levon@movementarian.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: debugfs in the namespace
Message-ID: <20041217183922.GA97134@compsoc.man.ac.uk>
References: <20041216110002.3e0ddf52@lembas.zaitcev.lan> <cptlv8$9kd$1@terminus.zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cptlv8$9kd$1@terminus.zytor.com>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Graham Coxon - Happiness in Magazines
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *1CfN0c-0002h2-Mc*wjhV3iCd6DU*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2004 at 04:06:00AM +0000, H. Peter Anvin wrote:

> /dev is the normal place where stuff related to the user/kernel
> interface should go, so /dev/debug or /dev/debugfs would be the right
> answer (and yes, /proc and /sys violate this, but we're stuck with
> those.)

There is also /dev/oprofile/ as recent 2.6 precedent for this.

john
