Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751048AbWCYSjc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751048AbWCYSjc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 13:39:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751058AbWCYSjc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 13:39:32 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:23183 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751048AbWCYSjb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 13:39:31 -0500
Date: Sat, 25 Mar 2006 19:39:06 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Benjamin <benchu@tamu.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: Modify the sock Structure!!
In-Reply-To: <4424ED2A.3040006@tamu.edu>
Message-ID: <Pine.LNX.4.61.0603251938110.29793@yvahk01.tjqt.qr>
References: <4424ED2A.3040006@tamu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Hello! I try to modify the sock Structure in sock.h in order to record some
> data!
> I just add a unsigned short in the end of the structure. such as:
>
> struct sock {

> safe or not. Is there any side-effect? Or I need to add additional code to
> avoid some unexpected
> situation?  Thank you very much!


Should be ok. For example, ipt_TPROXY/ipt_tproxy also adds something to 
struct sock (including enlarging fields in the middle of the struct);
I have not experienced any problem with it.


Jan Engelhardt
-- 
