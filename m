Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267861AbTGHWkY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 18:40:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267880AbTGHWkY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 18:40:24 -0400
Received: from 216-229-91-229-empty.fidnet.com ([216.229.91.229]:17425 "EHLO
	mail.icequake.net") by vger.kernel.org with ESMTP id S267861AbTGHWhD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 18:37:03 -0400
Date: Tue, 8 Jul 2003 17:51:37 -0500
From: Ryan Underwood <nemesis-lists@icequake.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Forking shell bombs
Message-ID: <20030708225137.GA1031@dbz.icequake.net>
References: <20030708202819.GM1030@dbz.icequake.net> <3F0B2CE6.8060805@nni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <3F0B2CE6.8060805@nni.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On an Athlon 600 running 2.4.20, with ulimit -u 2047, the box recovers
no problem from the fork bomb.

On my Celeron 800 running 2.4.21, ulimit -u 1500, the box recovers after
4-5 minutes.

ulimit -u 2047 (Debian's default ulimit), the box fights for 5-10
minutes, and no longer responds after 10.  I can see fork perrors in
the terminal like usual, but the machine no longer responds. (I waited
more than half an hour.)

-- 
Ryan Underwood, <nemesis at icequake.net>, icq=10317253
