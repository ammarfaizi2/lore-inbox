Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284464AbRLEQ0Y>; Wed, 5 Dec 2001 11:26:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284462AbRLEQ0P>; Wed, 5 Dec 2001 11:26:15 -0500
Received: from speech.linux-speakup.org ([129.100.109.30]:38550 "EHLO
	speech.braille.uwo.ca") by vger.kernel.org with ESMTP
	id <S284488AbRLEQ0A>; Wed, 5 Dec 2001 11:26:00 -0500
To: linux-kernel@vger.kernel.org
Subject: 2.5.1pre5 vt_kern.h small patch
From: Kirk Reiser <kirk@braille.uwo.ca>
Date: 05 Dec 2001 11:25:56 -0500
In-Reply-To: <20011205155950.68336.qmail@web20207.mail.yahoo.com>
Message-ID: <x7vgflr5uz.fsf@speech.braille.uwo.ca>
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
