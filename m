Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262371AbTESKi2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 06:38:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262373AbTESKi1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 06:38:27 -0400
Received: from f25.mail.ru ([194.67.57.151]:32521 "EHLO f25.mail.ru")
	by vger.kernel.org with ESMTP id S262371AbTESKi0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 06:38:26 -0400
From: "Andrey Borzenkov" <arvidjaar@mail.ru>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] submount: another removeable media handler
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: 10.41.11.1 via proxy [212.114.204.30]
Date: Mon, 19 May 2003 14:51:23 +0400
Reply-To: "Andrey Borzenkov" <arvidjaar@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E19HiEl-000D0k-00.arvidjaar-mail-ru@f25.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> Basically, in my opinion removable media should be handled by insert
> and removal detection, not by access detection.  Obviously, there are
> some sticky issues with that in the case where media can be removed
> without notice (like PC floppies or other manual-eject devices), but
> overall I think that is the correct approach.

You are absolutely right. Unfortunately, I am not aware of any general
way to request device to notify about media insertion/ejection.
Without such notification the only thing you can do is to poll - and
this is the same access detection in disguise. With disatvantage
that polling wastes system resources and is subject to races.

-andrey


