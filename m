Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261804AbULGNIn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261804AbULGNIn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 08:08:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261805AbULGNIm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 08:08:42 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:63627 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261804AbULGNIl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 08:08:41 -0500
Subject: Re: what does __foo means.
From: Josh Boyer <jdub@us.ibm.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: krishna <krishna.c@globaledgesoft.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.53.0412071354060.16729@yvahk01.tjqt.qr>
References: <41B5A5E1.9010608@globaledgesoft.com>
	 <Pine.LNX.4.53.0412071354060.16729@yvahk01.tjqt.qr>
Content-Type: text/plain
Message-Id: <1102424919.4118.2.camel@weaponx.rchland.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 07 Dec 2004 07:08:39 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-12-07 at 06:54, Jan Engelhardt wrote:
> >Hi all,
> >
> >    Can anyone tell me does double underscore before a function mean?
> >    In which scenario a programmer must use it.
> 
> From the POV of a compiler, _ is like [a-z]. The programmer may use it freely.

Yes, yes, but I don't think that was the question :).

In the kernel a function that begins with __ usually denotes an internal
function for that file or subsystem.  Not always, but usually.

josh

