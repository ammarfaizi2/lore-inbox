Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282081AbRLIACw>; Sat, 8 Dec 2001 19:02:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286095AbRLIACm>; Sat, 8 Dec 2001 19:02:42 -0500
Received: from speech.linux-speakup.org ([129.100.109.30]:45538 "EHLO
	speech.braille.uwo.ca") by vger.kernel.org with ESMTP
	id <S282081AbRLIACg>; Sat, 8 Dec 2001 19:02:36 -0500
To: linux-kernel@vger.kernel.org
Subject: 2.5.1pre7 vt_kern.h small patch, take 3
From: Kirk Reiser <kirk@braille.uwo.ca>
Date: 08 Dec 2001 19:02:32 -0500
In-Reply-To: <1007855483.536.0.camel@monster>
Message-ID: <x7d71pxntz.fsf_-_@speech.braille.uwo.ca>
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
