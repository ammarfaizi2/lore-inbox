Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262037AbTEEIHR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 04:07:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262038AbTEEIHR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 04:07:17 -0400
Received: from elin.scali.no ([62.70.89.10]:21378 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id S262037AbTEEIHP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 04:07:15 -0400
Subject: The disappearing sys_call_table export.
From: Terje Eggestad <terje.eggestad@scali.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Scali AS
Message-Id: <1052122784.2821.4.camel@pc-16.office.scali.no>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 05 May 2003 10:19:45 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now that it seem that all are in agreement that the sys_call_table
symbol shall not be exported to modules, are there any work in progress
to allow modules to get an event/notification whenever a specific
syscall is being called?

We have a specific need to trace mmap() and sbrk() calls. 



-- 
_________________________________________________________________________

Terje Eggestad                  mailto:terje.eggestad@scali.no
Scali Scalable Linux Systems    http://www.scali.com

Olaf Helsets Vei 6              tel:    +47 22 62 89 61 (OFFICE)
P.O.Box 150, Oppsal                     +47 975 31 574  (MOBILE)
N-0619 Oslo                     fax:    +47 22 62 89 51
NORWAY            
_________________________________________________________________________

