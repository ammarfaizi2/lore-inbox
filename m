Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263818AbUHWNC6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263818AbUHWNC6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 09:02:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263875AbUHWNC6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 09:02:58 -0400
Received: from the-village.bc.nu ([81.2.110.252]:60304 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S263818AbUHWNC5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 09:02:57 -0400
Subject: Re: 2.6.8.1-mm4
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <m14qmu4ffk.fsf@ebiederm.dsl.xmission.com>
References: <20040822013402.5917b991.akpm@osdl.org>
	 <m14qmu4ffk.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1093262442.29522.22.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 23 Aug 2004 13:00:43 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-08-23 at 06:00, Eric W. Biederman wrote:
> The function still looks fishy as there is another access
> to rq outside of ide_lock, a few lines earlier.

HWGROUP(drive) is always valid for any live device. If this goes non
valid you have another bug and you need to fix the HWGROUP(drive) bug.

Alan


