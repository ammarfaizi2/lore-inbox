Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261401AbVCNJ1r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261401AbVCNJ1r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 04:27:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261415AbVCNJ1r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 04:27:47 -0500
Received: from [151.97.230.9] ([151.97.230.9]:43529 "HELO ssc.unict.it")
	by vger.kernel.org with SMTP id S261401AbVCNJ1p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 04:27:45 -0500
Subject: [patch 1/1] Fix kconfig docs typo: integer -> int
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Thu, 10 Mar 2005 16:38:58 +0100
Message-Id: <20050310153900.B75A56475@zion>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Trivial correction: the type of numbers for Kconfig is not integer but int (I
just verified because I followed the wrong docs and got a error, I looked
elsewhere and they are using int, and int works for me). Please apply.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.11-paolo/Documentation/kbuild/kconfig-language.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN Documentation/kbuild/kconfig-language.txt~doc-big-typo-fix Documentation/kbuild/kconfig-language.txt
--- linux-2.6.11/Documentation/kbuild/kconfig-language.txt~doc-big-typo-fix	2005-03-10 16:35:38.000000000 +0100
+++ linux-2.6.11-paolo/Documentation/kbuild/kconfig-language.txt	2005-03-10 16:36:09.000000000 +0100
@@ -48,7 +48,7 @@ Menu attributes
 A menu entry can have a number of attributes. Not all of them are
 applicable everywhere (see syntax).
 
-- type definition: "bool"/"tristate"/"string"/"hex"/"integer"
+- type definition: "bool"/"tristate"/"string"/"hex"/"int"
   Every config option must have a type. There are only two basic types:
   tristate and string, the other types are based on these two. The type
   definition optionally accepts an input prompt, so these two examples
@@ -100,7 +100,7 @@ applicable everywhere (see syntax).
   symbols.
 
 - numerical ranges: "range" <symbol> <symbol> ["if" <expr>]
-  This allows to limit the range of possible input values for integer
+  This allows to limit the range of possible input values for int
   and hex symbols. The user can only input a value which is larger than
   or equal to the first symbol and smaller than or equal to the second
   symbol.
_
