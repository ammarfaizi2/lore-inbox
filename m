Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262463AbTD3Vso (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 17:48:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262464AbTD3Vso
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 17:48:44 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:37744 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S262463AbTD3Vsn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 17:48:43 -0400
Date: Wed, 30 Apr 2003 18:00:50 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: Frode Isaksen <fisaksen@bewan.com>
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: PATCH: usb-uhci: interrupt out with urb->interval 0  [linux-usb-devel]
Message-ID: <20030430180050.A17797@devserv.devel.redhat.com>
References: <20030429155842.A9215@devserv.devel.redhat.com> <B693AA1B-7B08-11D7-8859-003065EF6010@bewan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <B693AA1B-7B08-11D7-8859-003065EF6010@bewan.com>; from fisaksen@bewan.com on Wed, Apr 30, 2003 at 02:38:58PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Wed, 30 Apr 2003 14:38:58 +0200
> From: Frode Isaksen <fisaksen@bewan.com>

> I have tested the patch with the Unicorn (ST70137) adsl usb chip and it 
> is ok. Thanks...

> Do you think it will be in the official 2.4.21 kernel ?

This is a question to Greg Kroah. He wanted to put brakes on
it due to insufficient testing. Personally, I do not agree.
I think we should put it into -rc2 and see if anything breaks
(which is unlikely in this case). But ultimately it's his call.

-- Pete
