Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263930AbTGFWWU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 18:22:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263971AbTGFWWU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 18:22:20 -0400
Received: from lns-th2-5f-81-56-227-145.adsl.proxad.net ([81.56.227.145]:39809
	"EHLO smtp.ced-2.eu.org") by vger.kernel.org with ESMTP
	id S263930AbTGFWWS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 18:22:18 -0400
Message-ID: <3F08A47F.1060902@ifrance.com>
Date: Mon, 07 Jul 2003 00:36:47 +0200
From: ced2 <ced2ml@ifrance.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20030624
X-Accept-Language: fr-fr, fr, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [2.4.21-ac4] Compile Error
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Compiling with gcc 3.2.2 :

In file included from poly_atan.c:19:
poly.h: In function `add_Xsig_Xsig':
poly.h:78: parse error before "movl"
poly.h:78: `addl' undeclared (first use in this function)
poly.h:78: (Each undeclared identifier is reported only once
poly.h:78: for each function it appears in.)
poly.h:78: parse error before '%' token
poly.h:78: `adcl' undeclared (first use in this function)
poly.h:78: parse error before '%' token
In file included from poly_atan.c:19:
poly.h:81:59: warning: multi-line string literals are deprecated
poly.h:78: `g' undeclared (first use in this function)
poly.h:78: parse error before string constant
poly.h:82:46: warning: multi-line string literals are deprecated
poly.h:83:32: warning: multi-line string literals are deprecated
poly.h:78: `movl' undeclared (first use in this function)
poly.h:78: parse error before '%' token
poly.h:94: `movl' used prior to declaration
poly.h:94: warning: implicit declaration of function `movl'
poly.h:94: parse error before '%' token
poly.h:94: parse error before '%' token
poly.h:95: parse error before '%' token
poly.h:96: parse error before '%' token
poly.h:97: invalid suffix on integer constant
poly.h:97: `jnc' undeclared (first use in this function)
poly.h:98: `rcrl' undeclared (first use in this function)
poly.h:98: `rcrl' used prior to declaration
poly.h:98: warning: implicit declaration of function `rcrl'
poly.h:98: parse error before '%' token
poly.h:99: warning: implicit declaration of function `incl'
poly.h:99: parse error before '%' token
poly.h:100: invalid suffix on integer constant
poly.h:100: `jmp' undeclared (first use in this function)
poly.h:102:20: warning: multi-line string literals are deprecated
poly.h:103:20: warning: multi-line string literals are deprecated
poly.h:104:28: warning: multi-line string literals are deprecated
poly.h:105:17: warning: multi-line string literals are deprecated
poly.h:110:58: warning: multi-line string literals are deprecated
poly.h:113:32: warning: multi-line string literals are deprecated
poly.h:114:35: warning: multi-line string literals are deprecated
poly.h:102: warning: implicit declaration of function `subl'
poly.h:102: parse error before '%' token
poly.h:102: parse error before '%' token
poly.h:115:75: warning: multi-line string literals are deprecated
poly.h:102: `sbbl' undeclared (first use in this function)
poly.h:102: parse error before '%' token
poly.h:116:77: warning: multi-line string literals are deprecated
poly.h:102: parse error before '%' token
poly.h:117:77: warning: multi-line string literals are deprecated
poly.h:102: parse error before string constant
poly.h:118:48: warning: multi-line string literals are deprecated
poly.h:118:48: missing terminating " character
poly.h:81:59: possible start of unterminated string literal
poly.h:15:1: unterminated #ifndef
poly_atan.c: In function `poly_atan':
poly_atan.c:137: warning: implicit declaration of function `negate_Xsig'
poly_atan.c:174: `oddnegterms' undeclared (first use in this function)
poly_atan.c:176: warning: implicit declaration of function `add_two_Xsig'
poly_atan.c: In function `add_Xsig_Xsig':
poly_atan.c:230: parse error at end of input
gmake[2]: *** [poly_atan.o] Error 1
gmake[2]: Leaving directory `/usr/src/linux-2.4.21-ac4/arch/i386/math-emu'
gmake[1]: *** [first_rule] Error 2
gmake[1]: Leaving directory `/usr/src/linux-2.4.21-ac4/arch/i386/math-emu'
gmake: *** [_dir_arch/i386/math-emu] Error 2

