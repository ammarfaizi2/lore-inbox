Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261427AbRERScL>; Fri, 18 May 2001 14:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261430AbRERScB>; Fri, 18 May 2001 14:32:01 -0400
Received: from 202-123-209-152.outblaze.com ([202.123.209.152]:438 "EHLO
	mg.hk5.outblaze.com") by vger.kernel.org with ESMTP
	id <S261427AbRERSbu>; Fri, 18 May 2001 14:31:50 -0400
Message-ID: <20010518183141.7601.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0
X-Mailer: MIME-tools 4.104 (Entity 4.117)
From: "Joshua Corbin" <jcorbin@linuxmail.org>
To: linux-kernel@vger.kernel.org
Date: Sat, 19 May 2001 02:31:40 +0800
Subject: Re: FIC AD11(AMD 761/VIA 686B) AGP port not supported [fixed]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, so appending agp_try_unsupported at boot gets the agp working (at least tolerably).  The problem now appears to be with the DRI part of X/Radeon driver, because after adding the line:
Option "noaccel" "true"
to my XF86Config, all is well.

Without it all that shows up on the screen is a bunch of boxes, from which you are then forced to C-A-Backspace, and C-A-Del, since the terminal is screwed.  So as long as I don't need 3D-accel, I'm once again Winblows free.  Thank-you all for the attention :-)

Josh

-- 

Get your free email from www.linuxmail.org 


Powered by Outblaze
