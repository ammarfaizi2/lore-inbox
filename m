Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282845AbRLGPww>; Fri, 7 Dec 2001 10:52:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282844AbRLGPwm>; Fri, 7 Dec 2001 10:52:42 -0500
Received: from speech.braille.uwo.ca ([129.100.109.30]:5580 "EHLO
	speech.braille.uwo.ca") by vger.kernel.org with ESMTP
	id <S282693AbRLGPwc>; Fri, 7 Dec 2001 10:52:32 -0500
To: linux-kernel@vger.kernel.org
Subject: 2.5.1pre6 vt_kern.h a small patch take 2
From: Kirk Reiser <kirk@braille.uwo.ca>
Date: 07 Dec 2001 10:52:29 -0500
In-Reply-To: <1007590378.24135.2.camel@dap>
Message-ID: <x7wuzzjade.fsf_-_@speech.braille.uwo.ca>
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
