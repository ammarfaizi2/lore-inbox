Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270317AbTGSN0S (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 09:26:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270333AbTGSN0S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 09:26:18 -0400
Received: from zork.zork.net ([64.81.246.102]:45963 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S270317AbTGSNZx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 09:25:53 -0400
To: netdev@oss.sgi.com
Cc: linux-kernel@vger.kernel.org
Subject: [2.6.0-test1-mm1] TCP connections over ipsec hang after a few
 seconds
From: Sean Neakums <sneakums@zork.net>
Mail-Followup-To: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Date: Sat, 19 Jul 2003 14:40:48 +0100
Message-ID: <6uk7aeab33.fsf@zork.zork.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've just set up transport mode IPsec between two machines with the
aid of the LARTC IPsec docs.  Both boxes are running 2.6.0-test1-mm1,
with a wireless/wired bridge between, using ipsec-tools 0.2.2.
Everything seems to be in order, except (big except) that TCP sessions
hang after a small number of seconds of use, usually between ten and
twenty.  The problem seems unrelated to the amount of data
transferred; I've tried both bulk rsync transfers and ssh sessions.
I've also tested the same boxes over 100baseT; still happens.

I'm not exactly sure what additional information to supply; my
experience with IPsec is limited to this past few hours'
experimentation.

