Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263738AbTFDRkI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 13:40:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263742AbTFDRkI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 13:40:08 -0400
Received: from windsormachine.com ([206.48.122.28]:15120 "EHLO
	router.windsormachine.com") by vger.kernel.org with ESMTP
	id S263738AbTFDRkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 13:40:07 -0400
Date: Wed, 4 Jun 2003 13:53:36 -0400 (EDT)
From: Mike Dresser <mdresser_l@windsormachine.com>
To: <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] [2.5] Non-blocking write can block
In-Reply-To: <019801c32abc$c233d1a0$ca41cb3f@amer.cisco.com>
Message-ID: <Pine.LNX.4.33.0306041352360.11936-100000@router.windsormachine.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Jun 2003, Hua Zhong wrote:

> We ran into this problem here in an embedded environment. It causes
> syslogd to hang and when this happens, everybody who talks to syslogd
> hangs. Which means you may not even be able to login. In the end we used
> exactly the same fix which seems to work.

I get this problem with writing to a remote syslog server, if the remote
syslog server hangs up or crashes no one can login to the machine that is
writing to the syslog server, even when the syslog server comes back.

Mike

