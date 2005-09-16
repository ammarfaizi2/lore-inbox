Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161014AbVIPBYF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161014AbVIPBYF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 21:24:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161018AbVIPBYF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 21:24:05 -0400
Received: from smtp101.sbc.mail.re2.yahoo.com ([68.142.229.104]:55644 "HELO
	smtp101.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1161014AbVIPBYE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 21:24:04 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [RFC] subclasses in sysfs to solve world peace
Date: Thu, 15 Sep 2005 20:23:43 -0500
User-Agent: KMail/1.8.2
Cc: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org,
       Vojtech Pavlik <vojtech@suse.cz>, Hannes Reinecke <hare@suse.de>,
       Patrick Mochel <mochel@digitalimplant.org>, airlied@linux.ie
References: <20050916002036.GA6149@suse.de> <20050916010438.GA12759@vrfy.org>
In-Reply-To: <20050916010438.GA12759@vrfy.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509152023.44003.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 15 September 2005 20:04, Kay Sievers wrote:
> I like that the child devices are actually below the parent device
> and represent the logical structure. I prefer that compared to the
> symlink-representation between the classes at the same directory
> level which the input patches propose.

Why don't we take it a step further and abandon classes altogether?
This way everything will grow from their respective hardware devices.

Class represent a set of objects with similar characteristics. In
this regard event0 is no "lesser" than input0. Although they are
linked they are objects of the same importance. I do want to see
all input interfaces without scanning bunch of directories.

-- 
Dmitry
