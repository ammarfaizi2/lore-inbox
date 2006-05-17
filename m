Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751042AbWEQWwx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751042AbWEQWwx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 18:52:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751113AbWEQWww
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 18:52:52 -0400
Received: from mail.siegenia-aubi.com ([217.5.180.129]:27791 "EHLO
	alg-1.siegenia-aubi.com") by vger.kernel.org with ESMTP
	id S1751042AbWEQWww convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 18:52:52 -0400
Message-ID: <FC7F4950D2B3B845901C3CE3A1CA67660181D33E@mxnd200-9.si-aubi.siegenia-aubi.com>
From: =?iso-8859-1?Q?=22D=F6hr=2C_Markus_ICC-H=22?= 
	<Markus.Doehr@siegenia-aubi.com>
To: Felipe Alfaro Solana <felipe.alfaro@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: replacing X Window System !
Date: Thu, 18 May 2006 00:52:47 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > No, not necessarily. It´s very possible to run only a single 
> > application from an RDP serving system (as you do with X), the 
> > application gets executed on the server and the display is 
> pushed to the client.
> 
> AFAIK, only ICA allows running single applications 
> (publishing), not RDP. And, BTW, they _do_ consume a complete 
> user session, so they're pretty a resource hog.

No - with RDP 5.2 this is possible as it is with Citrix. 

Doing this creates three processes on the system, a login process, a "shell"
(explorer) - and the process I'm executing/calling.

The main difference is - you can't "publish" applications, you need to know
how to call them (path). Everything else is pretty much the same as in
Citrix.

We make heavily use of this with the "Sun Global Desktop" software. That
software acts as middleware between the client and the server, they use
either Java or an AIP protocol to get the application to the desktop.
Working over that in X is as if you were sitting right in front of the
console.

-- 
Markus
