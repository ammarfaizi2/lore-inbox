Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284745AbRLPS2b>; Sun, 16 Dec 2001 13:28:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284746AbRLPS2V>; Sun, 16 Dec 2001 13:28:21 -0500
Received: from speech.braille.uwo.ca ([129.100.109.30]:59791 "EHLO
	speech.braille.uwo.ca") by vger.kernel.org with ESMTP
	id <S284745AbRLPS2C>; Sun, 16 Dec 2001 13:28:02 -0500
To: Linux Kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: 2.5.1pre11 vt_kern.h small patch
From: Kirk Reiser <kirk@braille.uwo.ca>
Date: 16 Dec 2001 13:27:58 -0500
In-Reply-To: <Pine.LNX.4.33.0112162010140.12126-200000@localhost.localdomain>
Message-ID: <x7bsgz9g0h.fsf@speech.braille.uwo.ca>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- linux/include/linux/vt_kern.h~	Wed Dec  5 10:12:17 2001
+++ linux/include/linux/vt_kern.h	Wed Dec  5 10:45:20 2001
@@ -7,6 +7,7 @@
  */
 
 #include <linux/config.h>
+#include <linux/tty.h> /* needed for MAX_NR_CONSOLES */
 #include <linux/vt.h>
 #include <linux/kd.h>
 

-- 

Kirk Reiser				The Computer Braille Facility
e-mail: kirk@braille.uwo.ca		University of Western Ontario
phone: (519) 661-3061
