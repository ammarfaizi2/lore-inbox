Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262531AbTJJGD7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 02:03:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262457AbTJJGD7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 02:03:59 -0400
Received: from pc3.povodiodry.cz ([62.77.113.53]:21122 "HELO pc11.op.pod.cz")
	by vger.kernel.org with SMTP id S262531AbTJJGD5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 02:03:57 -0400
From: "Vitezslav Samel" <samel@mail.cz>
Date: Fri, 10 Oct 2003 08:03:50 +0200
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [BUG] problems with USB memory pen
Message-ID: <20031010060350.GA5962@pc11.op.pod.cz>
Mail-Followup-To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi!

  Since 2.6.0-test6 ther is an annoying problem with my USB memory pen.
First time I insert it, kernel gives it "sdc" (which is O.K.). Next time
kernel gives it "sdd", "sde" and so on. Seems like someone is not releasing
unused SCSI devices.

  I narrowed down this problem to linux-2.6.0-test5-bk14. There are no USB
changes, but are SCSI changes which I don't understand that well to fix my
problem.

  I would appreciate if someone will look at it.

	Thanks,
		Vita Samel
