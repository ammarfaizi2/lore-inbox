Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261862AbTJIAoN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 20:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261856AbTJIAoN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 20:44:13 -0400
Received: from smtp14.eresmas.com ([62.81.235.114]:54958 "EHLO
	smtp14.eresmas.com") by vger.kernel.org with ESMTP id S261842AbTJIAoM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 20:44:12 -0400
Message-ID: <3F84AF3C.9050408@wanadoo.es>
Date: Thu, 09 Oct 2003 02:43:40 +0200
From: Xose Vazquez Perez <xose@wanadoo.es>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: gl, es, en
MIME-Version: 1.0
To: linux-scsi <linux-scsi@vger.kernel.org>
CC: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: two sym53c8xx.o modules
X-Enigmail-Version: 0.63.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

kernel 2.4 has two modules with *same name*:
/lib/modules/2.4.XX/kernel/drivers/scsi/sym53c8xx_2/sym53c8xx.o
/lib/modules/2.4.XX/kernel/drivers/scsi/sym53c8xx.o

"# modprobe sym53c8xx" tries to load sym53c8xx.o first and then sym53c8xx_2/sym53c8xx.o
bug or feature?

should be sym53c8xx_2/sym53c8xx.o renamed to sym53c8xx_2/sym53c8xx_2.o ?
                                                                  ^^
-thanks-

