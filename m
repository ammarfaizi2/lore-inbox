Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932530AbWCHJvh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932530AbWCHJvh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 04:51:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932539AbWCHJvh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 04:51:37 -0500
Received: from smtp-out-02.utu.fi ([130.232.202.172]:9646 "EHLO
	smtp-out-02.utu.fi") by vger.kernel.org with ESMTP id S932530AbWCHJvg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 04:51:36 -0500
Date: Wed, 08 Mar 2006 11:51:33 +0200
From: Jan Knutar <jk-lkml@sci.fi>
Subject: Re: [future of drivers?] a proposal for binary drivers.
In-reply-to: <ec92bc30603080135j5257c992k2452f64752d38abd@mail.gmail.com>
To: Anshuman Gholap <anshu.pg@gmail.com>
Cc: linux-kernel@vger.kernel.org
Message-id: <200603081151.33349.jk-lkml@sci.fi>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
References: <ec92bc30603080135j5257c992k2452f64752d38abd@mail.gmail.com>
User-Agent: KMail/1.6.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 08 March 2006 11:35, Anshuman Gholap wrote:

> linux installed, i go digicam not working on linux, webcam not working

I thought cameras in general did usb masstorage thing and thus
worked with anything?

> countable on hands but cannot be held countable for work cause they do
> it as hobby/"insert anything which says working for free", now for a

Actually quite alot of them do it for work, including Torvalds and Cox.

> peice of code like linux kernel, such kind of aloofness regarding
> manpower and kind_of nazism in not allowing others to dynamically
> get_work_done (like binary driver) seems totally wrong.

Unfortunately the license (GPL) was chosen along time ago and can't
really be changed at this point.
 
> 2) there are two possibilities here, a) linus and co can gather in a
> building pay all intellects and allow fast driver developments, b)
> allow binary drivers to work with linux kernel dynamically(with their
> own license what they choose).

The real question is: Why do binary-only drivers need to exist?


> b) ofcourse is like china accepting democracy cause that the only way
> to continue living, but although it sounds that extreme, i can see
> ONLY THAT to happen sooner or later when one day linus is not part of
> the team controlling linux kernel, so why not start to make it happen
> right now and shape it the way it can be benificial to everyone?

GPL.

You could try direct your efforts at *BSD which has a more liberal
licensing policy.
Microsoft, for example, has a version of .NET for FreeBSD, but not
for Linux. Presumably because of the license differences.

> like there is mm kernel we can have kernel-dri-2.*** which the desktop
> users can use knowingly that third party drivers can work with mixture
> of lincenses. there even can be rating system for a company which can
> be rated for their quality of drivers, so the users know before hand.

Already in place. The "Tainted" flag.

In general: Binary drivers == bad.
After that, there are several levels of bad...

Besides... Looking at Win64, it looks like hardware manufacturers
have problems coming up with drivers... If they had done them
open-source for Linux or any other opensource operating system
in the first place, they'd most likely have less problems with the 64
bit transition right now.... Binary-only just hurts everyone.

> This email is very raw and not polished at all, this is just a bunch
> of thoughts which has came to my head 

The same here.
