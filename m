Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261358AbUBYOpL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 09:45:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261361AbUBYOpL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 09:45:11 -0500
Received: from rrzd1.rz.uni-regensburg.de ([132.199.1.6]:13211 "EHLO
	rrzd1.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id S261358AbUBYOpH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 09:45:07 -0500
From: "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: linux-kernel@vger.kernel.org
Date: Wed, 25 Feb 2004 15:41:03 +0100
MIME-Version: 1.0
Subject: Question (tty ldisc): safe to use disc_data without changing ldisc?
Message-ID: <403CC211.15219.1B38200@localhost>
X-mailer: Pegasus Mail for Windows (v4.12a)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Content-Conformance: HerringScan-0.25/Sophos-3.77+2.18+2.07.040+05 January 2004+87028@20040225.143914Z
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello experts,

I have a question: In a kernel modification I dynamically add some data 
structure that is referred to by using the "disc_data" member of the tty 
structure. My question is: is it safe to do that (I'm using a new magic number 
of course), or can some other code just replace my reference? If it's not 
safe, how would I correctly do that?

Any pointers to written (up to date) online documents are OK...

Regards
Ulrich
P.S. not subscribed here, I won't survive the traffic. Please [B]CC: to me.


