Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264676AbTFARSu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 13:18:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264677AbTFARSu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 13:18:50 -0400
Received: from A17-250-248-87.apple.com ([17.250.248.87]:14053 "EHLO
	smtpout.mac.com") by vger.kernel.org with ESMTP id S264676AbTFARSt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 13:18:49 -0400
Date: Mon, 2 Jun 2003 03:31:10 +1000
Subject: Re: Kernel 2.5.70 compilation fails
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v552)
Cc: linux-kernel@vger.kernel.org
To: Yoann <linux-yoann@ifrance.com>
From: Stewart Smith <stewartsmith@mac.com>
In-Reply-To: <3EDA1EBA.9020005@ifrance.com>
Message-Id: <D59A003F-9456-11D7-AF84-00039346F142@mac.com>
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.552)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, June 2, 2003, at 01:41  AM, Yoann wrote:
> make[3]: *** No rule to make target `drivers/ide/ide-geometry.s', 
> needed by
> `drivers/ide/ide-geometry.o'.  Stop.

ide-geometry.c was removed with 2.5.70 (was in 2.5.69), your source 
directory probably isn't patched properly or something else weird. Grab 
a fresh tarball or freshly patch up to 2.5.70.

------------------------------
Stewart Smith
stewartsmith@mac.com
Ph: +61 4 3884 4332
ICQ: 6734154
http://www.flamingspork.com/       http://www.linux.org.au

