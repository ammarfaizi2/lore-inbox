Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262025AbUKJR6I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262025AbUKJR6I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 12:58:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262026AbUKJR6I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 12:58:08 -0500
Received: from THUNK.ORG ([69.25.196.29]:33922 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S262025AbUKJR55 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 12:57:57 -0500
Date: Wed, 10 Nov 2004 12:54:40 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org,
       Jason.Jorgensen@comtrol.com, Keith.Hammerbeck@comtrol.com,
       Steve.Erler@comtrol.com
Subject: Re: Licencing of drivers/char/rocket.c ?
Message-ID: <20041110175440.GA10178@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Linus Torvalds <torvalds@osdl.org>, Adrian Bunk <bunk@stusta.de>,
	linux-kernel@vger.kernel.org, Jason.Jorgensen@comtrol.com,
	Keith.Hammerbeck@comtrol.com, Steve.Erler@comtrol.com
References: <8CA8D92FACEB5447AB1ABA12B13A54CE9F2E88@exchange-2.comtrol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8CA8D92FACEB5447AB1ABA12B13A54CE9F2E88@exchange-2.comtrol.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 09, 2004 at 01:38:11PM -0600, Jason.Jorgensen@comtrol.com wrote:
> On Tuesday, November 09, 2004 10:58 AM, Theodore Ts'o <tytso@mit.edu> wrote:
>> I developed the Rocketport device driver under contract of Comtrol,
>> with the understanding that the resulting device driver would be
>> released under the GPL.  So I believe the correct way of resolving the
>> conflicting copyright statements is to delete the following lines.
>> 
>> It would be good to get positive confirmation from Comtrol as well
>> that this is their understanding as well.  
>
> You are absolutely correct. That notice slipped by us and should not be in
> there. 
> 
> If someone with access to the mainline source could remove that for us we
> would appreciate it. 

Signed-off-by: "Theodore Ts'o" <tytso@thunk.org>
Acked-by: Jason.Jorgensen@comtrol.com

							- Ted

--- 1.46/drivers/char/rocket.c	2004-10-21 13:03:21 -04:00
+++ edited/rocket.c	2004-11-10 12:49:44 -05:00
@@ -2453,30 +2453,6 @@
 }
 #endif
 
-/***********************************************************************
-		Copyright 1994 Comtrol Corporation.
-			All Rights Reserved.
-
-The following source code is subject to Comtrol Corporation's
-Developer's License Agreement.
-
-This source code is protected by United States copyright law and 
-international copyright treaties.
-
-This source code may only be used to develop software products that
-will operate with Comtrol brand hardware.
-
-You may not reproduce nor distribute this source code in its original
-form but must produce a derivative work which includes portions of
-this source code only.
-
-The portions of this source code which you use in your derivative
-work must bear Comtrol's copyright notice:
-
-		Copyright 1994 Comtrol Corporation.
-
-***********************************************************************/
-
 #ifndef TRUE
 #define TRUE 1
 #endif

