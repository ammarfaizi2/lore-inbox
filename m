Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262001AbTDEKWS (for <rfc822;willy@w.ods.org>); Sat, 5 Apr 2003 05:22:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262003AbTDEKWS (for <rfc822;linux-kernel-outgoing>); Sat, 5 Apr 2003 05:22:18 -0500
Received: from siaag1ac.compuserve.com ([149.174.40.5]:42387 "EHLO
	siaag1ac.compuserve.com") by vger.kernel.org with ESMTP
	id S262001AbTDEKWR (for <rfc822;linux-kernel@vger.kernel.org>); Sat, 5 Apr 2003 05:22:17 -0500
Date: Sat, 5 Apr 2003 05:32:03 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: PATCH: Fixes for ide-disk.c
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200304050533_MC3-1-331B-7B23@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


John Bradford wrote:


>Did we ever establish what the best way to ensure
>that the write cache is flushed, is?  An explicit
>cache flush and spin down are both necessary, but
>I had problems with drives spinning back up when
>we did the spindown first.


Disks that don't support flush should be sent an IDLE command, IIRC.



--
 Chuck
 I am not a number!
