Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261758AbUKAKjL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261758AbUKAKjL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 05:39:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261754AbUKAKjL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 05:39:11 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:64942 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261759AbUKAKjH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 05:39:07 -0500
Date: Mon, 1 Nov 2004 11:39:01 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: ych43 <ych43@student.canterbury.ac.nz>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: TCP port numbers
In-Reply-To: <41838517@webmail>
Message-ID: <Pine.LNX.4.53.0411011138130.11179@yvahk01.tjqt.qr>
References: <41838517@webmail>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Hi,
> I got one question about unix socket functions. I have two machines (called A
>and B). I use A to telnet B, get the root password of B. Is there any unix
>socket function I can use to get the port number of A on B. Obviously, the

The 'struct sockaddr_in' you're filling in on B's site with the call with
accept() also fills in the port number.

>port number of B is 23. I want to use a socket function implemented on B to
>get the port number of A because a TCP connection is established between them.
>  I greatly appreciate it if you help me. Thank you in advance.
>  Xue


Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
