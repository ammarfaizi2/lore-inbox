Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751401AbWCLBe7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751401AbWCLBe7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Mar 2006 20:34:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751417AbWCLBe6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Mar 2006 20:34:58 -0500
Received: from user-0c93tin.cable.mindspring.com ([24.145.246.87]:33249 "EHLO
	tsurukikun.utopios.org") by vger.kernel.org with ESMTP
	id S1751401AbWCLBe6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Mar 2006 20:34:58 -0500
From: Luke-Jr <luke@dashjr.org>
To: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Subject: Re: can I bring Linux down by running "renice -20 cpu_intensive_process"?
Date: Sun, 12 Mar 2006 01:41:05 +0000
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <441180DD.3020206@wpkg.org> <Pine.LNX.4.61.0603101540310.23690@yvahk01.tjqt.qr> <yw1xbqwe2c2x.fsf@agrajag.inprovide.com>
In-Reply-To: <yw1xbqwe2c2x.fsf@agrajag.inprovide.com>
Public-GPG-Key: 0xD53E9583
Public-GPG-Key-URI: http://dashjr.org/~luke-jr/myself/Luke-Jr.pgp
IM-Address: luke-jr@jabber.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200603120141.08129.luke@dashjr.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 10 March 2006 22:01, Måns Rullgård wrote:
> Sysrq+n changes all realtime tasks to normal priority.

Would the kernel's main loop (where I presume Sysreq is handled) get a chance 
to run with a constantly busy realtime task?
