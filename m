Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261684AbVDEKZ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261684AbVDEKZ2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 06:25:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261700AbVDEKW4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 06:22:56 -0400
Received: from relay.rost.ru ([80.254.111.11]:42703 "EHLO relay.rost.ru")
	by vger.kernel.org with ESMTP id S261670AbVDEKS7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 06:18:59 -0400
Date: Tue, 5 Apr 2005 14:18:50 +0400
From: Andrey Panin <pazke@donpac.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc2-mm1
Message-ID: <20050405101850.GA6078@pazke>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20050405000524.592fc125.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050405000524.592fc125.akpm@osdl.org>
X-Uname: Linux 2.6.11-pazke i686
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 095, 04 05, 2005 at 12:05:24AM -0700, Andrew Morton wrote:

what useful this part of the patch is supposed to do ?
Looks like the result of whitespace damage.


--- linux-2.6.12-rc2/drivers/acpi/sleep/main.c	2005-03-02 01:09:19.000000000 -0800
+++ 25/drivers/acpi/sleep/main.c	2005-04-04 22:33:10.000000000 -0700

<snip>

@@ -190,16 +180,16 @@ static int __init init_ints_after_s1(str
 
 static struct dmi_system_id __initdata acpisleep_dmi_table[] = {
 	{
-		.callback = init_ints_after_s1,
-		.ident = "Toshiba Satellite 4030cdt",
-		.matches = { DMI_MATCH(DMI_PRODUCT_NAME, "S4030CDT/4.3"), },
-	},
-	{ },
+	 .callback = init_ints_after_s1,
+	 .ident = "Toshiba Satellite 4030cdt",
+	 .matches = {DMI_MATCH(DMI_PRODUCT_NAME, "S4030CDT/4.3"),},
+	 },
+	{},
 };

