Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261564AbTEYJiZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 May 2003 05:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261566AbTEYJiY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 05:38:24 -0400
Received: from iny.iki.fi ([194.29.193.217]:6528 "HELO iny.iki.fi")
	by vger.kernel.org with SMTP id S261564AbTEYJiY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 05:38:24 -0400
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Alt-Lock & Ctrl-Lock features in 2.4.21-rc2
From: iny+dev@iki.fi (=?iso-8859-1?q?Ilpo_Nyyss=F6nen?=)
Organization: ypy - it's just a name
X-Face: 0ZX7mLJt~voq-;MII3]u'Rxa?zR6Ip^'#0H!?>+AQU;dp"LLUMnUA[JR<+@UO||2ewYj}qV
 CrI|lF,v+z;!y^s?=P`|$2d7J%X|2#XACg31e,G1bf7bF@w|#qL5'?\Jzrutw08eo+jBY[v&7jolI=
 1%=trC6v@!bElm1.H*'&.,r#r4:gD+,};0sPwHi`JI-_AdkA9pcW+Fp6()!qH/-GO5uyHy2t/TzH.i
 yE\H5wJ1_pMki:0U_Vm]G]k*A}=?o,SOoFw=@Ft
Date: Sun, 25 May 2003 12:51:32 +0300
Message-ID: <m3llwv73rv.fsf@iny.iki.fi>
User-Agent: Gnus/5.1003 (Gnus v5.10.3) XEmacs/21.5 (cauliflower, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The "keyboard changes" by alan in 2.4.21-pre5 seem to cause Alt-Lock
and Ctrl-Lock feature in X. (The workaround that ignores duplicate key
release events.)

What do do:

1) press and hold alt
2) press and release altgr
3) release alt

=> Now alt is locked down, pressing and releasing alt releases the lock.

Also xev doesn't show the release event for the alt. The same happens
with left ctrl + right ctrl => ctrl locked. 

I just commented out the workaround there and now it works as it used
to.

-- 
Ilpo Nyyssönen # biny # /* :-) */

