Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264453AbUE3Xuz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264453AbUE3Xuz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 19:50:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264471AbUE3Xuy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 19:50:54 -0400
Received: from smtp808.mail.sc5.yahoo.com ([66.163.168.187]:17263 "HELO
	smtp808.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264453AbUE3Xux (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 19:50:53 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: SERIO_USERDEV patch for 2.6
Date: Sun, 30 May 2004 18:50:48 -0500
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org,
       Sau Dan Lee <danlee@informatik.uni-freiburg.de>, tuukkat@ee.oulu.fi
References: <xb7r7t2b3mb.fsf@savona.informatik.uni-freiburg.de> <200405301116.31356.dtor_core@ameritech.net> <20040530205119.GD1971@ucw.cz>
In-Reply-To: <20040530205119.GD1971@ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405301850.49219.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 30 May 2004 03:51 pm, Vojtech Pavlik wrote:
> On Sun, May 30, 2004 at 11:16:31AM -0500, Dmitry Torokhov wrote:
> 
> > But in the meantime marking several ports raw will allow most of the users
> > use old means of communicating with their pointing devices without too
> > much effort.
> 
> It'd be good to find out what devices we don't support yet (I know of
> ALPS, which we have a patch pending for and IBM TouchPoints), too. 
> 

Sau Dan Lee's Lifebook touchscreen ;) The data processing seems to be
trivial, but I don't have any idea how to detect it. And without being
able to explicitly control binding for a specific serio port its hard
to do drivers for hardware that we can't autodetect. We just have to
assume that device behind a port is of specific type and when there
are many ports its usually wrong.
 
> As an interim solution, your patch plus a simple serio->userspace driver
> would work, too.
> 

-- 
Dmitry
