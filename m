Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265002AbTGBO7t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 10:59:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265024AbTGBO7t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 10:59:49 -0400
Received: from aslan.scsiguy.com ([63.229.232.106]:33796 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP id S265002AbTGBO7t
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 10:59:49 -0400
Date: Wed, 02 Jul 2003 09:14:08 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: Roberto Slepetys Ferreira <slepetys@homeworks.com.br>,
       linux-kernel@vger.kernel.org
Subject: Re: Probably 2.4 kernel or AIC7xxx module trouble
Message-ID: <1083830000.1057158848@aslan.scsiguy.com>
In-Reply-To: <00d901c340a8$810556c0$3300a8c0@Slepetys>
References: <00d901c340a8$810556c0$3300a8c0@Slepetys>
X-Mailer: Mulberry/3.0.3 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The system halts easily if I do a large I/O, like reindexing a database,
> giving me some messages like: (scsi0:A:1:0): Locking max tag count at 128...

The "Locking max tag count" messages are normal.  It means the SCSI
driver was able to determine the maximum queue depth of your drive.

6.2.8 is rather old.  I don't know that upgrading the aic7xxx driver
will solve your problem, but it might be worth a shot.  The latest
is available here:

http://people.FreeBSD.org/~gibbs/linux/SRC/

After upgrading, you should be at 6.2.36.

--
Justin

