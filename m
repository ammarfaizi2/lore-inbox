Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264692AbUFLIsn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264692AbUFLIsn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jun 2004 04:48:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264689AbUFLIsn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jun 2004 04:48:43 -0400
Received: from smtp.etmail.cz ([160.218.43.220]:59025 "EHLO smtp.etmail.cz")
	by vger.kernel.org with ESMTP id S264695AbUFLIrc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jun 2004 04:47:32 -0400
From: pavel@ucw.cz
To: "=?ISO-8859-1?Q?Nigel_Cunningham?=" <ncunningham@linuxmail.org>,
       "=?ISO-8859-1?Q??= =?ISO-8859-1?Q?Herbert_Xu?=" 
	<herbert@gondor.apana.org.au>
Cc: "=?ISO-8859-1?Q?Pavel_Machek?=" <pavel@suse.cz>,
       "=?ISO-8859-1?Q?Patrick?= =?ISO-8859-1?Q?_Mochel?=" 
	<mochel@digitalimplant.org>,
       "=?ISO-8859-1?Q?ker?= =?ISO-8859-1?Q?nel_list?=" 
	<linux-kernel@vger.kernel.org>,
       akpm@zip.com.au
Subject: =?ISO-8859-1?Q?RE:Re:_Fix_memory_leak_in_swsusp?=
Date: 12 Jun 2004 10:45:17 +0000
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <20040612084708.23965272BA@smtp.etmail.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At this point it is okay to memcpy - it is copying pagedir, at that point we are outside any critical session. --p

------
Written-on-t68i. Sorry.

