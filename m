Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261349AbUJXBdW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261349AbUJXBdW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 21:33:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261353AbUJXBdW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 21:33:22 -0400
Received: from dsl017-059-236.wdc2.dsl.speakeasy.net ([69.17.59.236]:22237
	"EHLO marta.kurtwerks.com") by vger.kernel.org with ESMTP
	id S261349AbUJXBdT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 21:33:19 -0400
Date: Sat, 23 Oct 2004 21:39:38 -0400
From: Kurt Wall <kwall@kurtwerks.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: IDE warning: "Wait for ready failed before probe!"
Message-ID: <20041024013938.GD3245@kurtwerks.com>
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>
References: <1098564453l.9607l.0l@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1098564453l.9607l.0l@localhost>
User-Agent: Mutt/1.4.2.1i
X-Operating-System: Linux 2.6.9
X-Woot: Woot!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 23, 2004 at 08:47:33PM +0000, Alan Jenkins took 46 lines to write:
> I have no problems (I hope!), but the warnings I get when linux (2.6.9) 
> tries to probe a non existant IDE device (controller/channel (?) not  
> hard disk) are slightly over the top..
> 
> 1. Are these warnings usual for a nonexistant IDE drive?
> 2. Could they be toned down?

Disable CONFIG_IDE_GENERIC
- or -
Use the ideX=noprobe boot parm, replacing X with the interface number
not to probe.

Kurt
-- 
A lack of leadership is no substitute for inaction.
