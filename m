Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263792AbTJ1ApV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 19:45:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263793AbTJ1ApV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 19:45:21 -0500
Received: from cc15467-a.groni1.gr.home.nl ([217.120.147.78]:32552 "HELO
	cc15467-a.groni1.gr.home.nl") by vger.kernel.org with SMTP
	id S263792AbTJ1ApA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 19:45:00 -0500
Date: Tue, 28 Oct 2003 01:44:58 +0059
From: Han Boetes <han@mijncomputer.nl>
To: linux-kernel@vger.kernel.org
Subject: [PATCH][TRIVIAL] menuconfig alternate theme
Message-ID: <20031028004520.GG13373@boetes.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="wzJLGUyc3ArbnUjN"
Content-Disposition: inline
X-GPG-Key: http://www.xs4all.nl/~hanb/keys/Han_pubkey.gpg
X-GPG-Fingerprint: EB66 D194 AB3F 4C57 49EF 6795 44AE E0D8 3F38 7301
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wzJLGUyc3ArbnUjN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

To react on this thread somewhat:

  http://marc.theaimsgroup.com/?l=linux-kernel&m=104202311306008&w=2

I made an alternative theme for menuconfig with a black background and
white/yellow/red/grey text which I find more readable. Of course it's
way to late to be included and I don't expect that at all. Just
something I wanted to share with the one or two people that share my
problem with reading the current settings.




# Han
-- 
 _/| VK                                                        |\_
// o\   Sooner or later you must pay for your sins. (Those    /o \\
|| ._)  who have already paid may disregard this fortune).   (_. ||
//__\                                                         /__\\
)___(                                                         )___(

--wzJLGUyc3ArbnUjN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="menuconfig_colors.diff"

--- scripts/lxdialog/colors.h.orig	2003-10-25 20:42:50.000000000 +0200
+++ scripts/lxdialog/colors.h	2003-10-28 00:46:28.618862592 +0100
@@ -24,123 +24,123 @@
  *
  *   *_FG = foreground
  *   *_BG = background
- *   *_HL = highlight?
+ *   *_HL = highlight
  */
-#define SCREEN_FG                    COLOR_CYAN
-#define SCREEN_BG                    COLOR_BLUE
+#define SCREEN_FG                    COLOR_BLACK
+#define SCREEN_BG                    COLOR_BLACK
 #define SCREEN_HL                    TRUE
 
 #define SHADOW_FG                    COLOR_BLACK
 #define SHADOW_BG                    COLOR_BLACK
-#define SHADOW_HL                    TRUE
+#define SHADOW_HL                    FALSE
 
-#define DIALOG_FG                    COLOR_BLACK
-#define DIALOG_BG                    COLOR_WHITE
+#define DIALOG_FG                    COLOR_WHITE
+#define DIALOG_BG                    COLOR_BLACK
 #define DIALOG_HL                    FALSE
 
-#define TITLE_FG                     COLOR_YELLOW
-#define TITLE_BG                     COLOR_WHITE
-#define TITLE_HL                     TRUE
+#define TITLE_FG                     COLOR_RED
+#define TITLE_BG                     COLOR_BLACK
+#define TITLE_HL                     FALSE
 
-#define BORDER_FG                    COLOR_WHITE
-#define BORDER_BG                    COLOR_WHITE
+#define BORDER_FG                    COLOR_BLACK
+#define BORDER_BG                    COLOR_BLACK
 #define BORDER_HL                    TRUE
 
-#define BUTTON_ACTIVE_FG             COLOR_WHITE
-#define BUTTON_ACTIVE_BG             COLOR_BLUE
-#define BUTTON_ACTIVE_HL             TRUE
+#define BUTTON_ACTIVE_FG             COLOR_YELLOW
+#define BUTTON_ACTIVE_BG             COLOR_RED
+#define BUTTON_ACTIVE_HL             FALSE
 
-#define BUTTON_INACTIVE_FG           COLOR_BLACK
-#define BUTTON_INACTIVE_BG           COLOR_WHITE
+#define BUTTON_INACTIVE_FG           COLOR_YELLOW
+#define BUTTON_INACTIVE_BG           COLOR_BLACK
 #define BUTTON_INACTIVE_HL           FALSE
 
-#define BUTTON_KEY_ACTIVE_FG         COLOR_WHITE
-#define BUTTON_KEY_ACTIVE_BG         COLOR_BLUE
+#define BUTTON_KEY_ACTIVE_FG         COLOR_YELLOW
+#define BUTTON_KEY_ACTIVE_BG         COLOR_RED
 #define BUTTON_KEY_ACTIVE_HL         TRUE
 
 #define BUTTON_KEY_INACTIVE_FG       COLOR_RED
-#define BUTTON_KEY_INACTIVE_BG       COLOR_WHITE
+#define BUTTON_KEY_INACTIVE_BG       COLOR_BLACK
 #define BUTTON_KEY_INACTIVE_HL       FALSE
 
-#define BUTTON_LABEL_ACTIVE_FG       COLOR_YELLOW
-#define BUTTON_LABEL_ACTIVE_BG       COLOR_BLUE
-#define BUTTON_LABEL_ACTIVE_HL       TRUE
+#define BUTTON_LABEL_ACTIVE_FG       COLOR_WHITE
+#define BUTTON_LABEL_ACTIVE_BG       COLOR_RED
+#define BUTTON_LABEL_ACTIVE_HL       FALSE
 
 #define BUTTON_LABEL_INACTIVE_FG     COLOR_BLACK
-#define BUTTON_LABEL_INACTIVE_BG     COLOR_WHITE
+#define BUTTON_LABEL_INACTIVE_BG     COLOR_BLACK
 #define BUTTON_LABEL_INACTIVE_HL     TRUE
 
-#define INPUTBOX_FG                  COLOR_BLACK
-#define INPUTBOX_BG                  COLOR_WHITE
+#define INPUTBOX_FG                  COLOR_YELLOW
+#define INPUTBOX_BG                  COLOR_BLACK
 #define INPUTBOX_HL                  FALSE
 
-#define INPUTBOX_BORDER_FG           COLOR_BLACK
-#define INPUTBOX_BORDER_BG           COLOR_WHITE
+#define INPUTBOX_BORDER_FG           COLOR_YELLOW
+#define INPUTBOX_BORDER_BG           COLOR_BLACK
 #define INPUTBOX_BORDER_HL           FALSE
 
-#define SEARCHBOX_FG                 COLOR_BLACK
-#define SEARCHBOX_BG                 COLOR_WHITE
+#define SEARCHBOX_FG                 COLOR_YELLOW
+#define SEARCHBOX_BG                 COLOR_BLACK
 #define SEARCHBOX_HL                 FALSE
 
 #define SEARCHBOX_TITLE_FG           COLOR_YELLOW
-#define SEARCHBOX_TITLE_BG           COLOR_WHITE
+#define SEARCHBOX_TITLE_BG           COLOR_BLACK
 #define SEARCHBOX_TITLE_HL           TRUE
 
-#define SEARCHBOX_BORDER_FG          COLOR_WHITE
-#define SEARCHBOX_BORDER_BG          COLOR_WHITE
+#define SEARCHBOX_BORDER_FG          COLOR_BLACK
+#define SEARCHBOX_BORDER_BG          COLOR_BLACK
 #define SEARCHBOX_BORDER_HL          TRUE
 
-#define POSITION_INDICATOR_FG        COLOR_YELLOW
-#define POSITION_INDICATOR_BG        COLOR_WHITE
-#define POSITION_INDICATOR_HL        TRUE
+#define POSITION_INDICATOR_FG        COLOR_RED
+#define POSITION_INDICATOR_BG        COLOR_BLACK
+#define POSITION_INDICATOR_HL        FALSE
 
-#define MENUBOX_FG                   COLOR_BLACK
-#define MENUBOX_BG                   COLOR_WHITE
+#define MENUBOX_FG                   COLOR_YELLOW
+#define MENUBOX_BG                   COLOR_BLACK
 #define MENUBOX_HL                   FALSE
 
-#define MENUBOX_BORDER_FG            COLOR_WHITE
-#define MENUBOX_BORDER_BG            COLOR_WHITE
+#define MENUBOX_BORDER_FG            COLOR_BLACK
+#define MENUBOX_BORDER_BG            COLOR_BLACK
 #define MENUBOX_BORDER_HL            TRUE
 
-#define ITEM_FG                      COLOR_BLACK
-#define ITEM_BG                      COLOR_WHITE
+#define ITEM_FG                      COLOR_WHITE
+#define ITEM_BG                      COLOR_BLACK
 #define ITEM_HL                      FALSE
 
 #define ITEM_SELECTED_FG             COLOR_WHITE
-#define ITEM_SELECTED_BG             COLOR_BLUE
-#define ITEM_SELECTED_HL             TRUE
+#define ITEM_SELECTED_BG             COLOR_RED
+#define ITEM_SELECTED_HL             FALSE
 
-#define TAG_FG                       COLOR_YELLOW
-#define TAG_BG                       COLOR_WHITE
-#define TAG_HL                       TRUE
+#define TAG_FG                       COLOR_RED
+#define TAG_BG                       COLOR_BLACK
+#define TAG_HL                       FALSE
 
 #define TAG_SELECTED_FG              COLOR_YELLOW
-#define TAG_SELECTED_BG              COLOR_BLUE
+#define TAG_SELECTED_BG              COLOR_RED
 #define TAG_SELECTED_HL              TRUE
 
-#define TAG_KEY_FG                   COLOR_YELLOW
-#define TAG_KEY_BG                   COLOR_WHITE
-#define TAG_KEY_HL                   TRUE
+#define TAG_KEY_FG                   COLOR_RED
+#define TAG_KEY_BG                   COLOR_BLACK
+#define TAG_KEY_HL                   FALSE
 
 #define TAG_KEY_SELECTED_FG          COLOR_YELLOW
-#define TAG_KEY_SELECTED_BG          COLOR_BLUE
+#define TAG_KEY_SELECTED_BG          COLOR_RED
 #define TAG_KEY_SELECTED_HL          TRUE
 
-#define CHECK_FG                     COLOR_BLACK
-#define CHECK_BG                     COLOR_WHITE
+#define CHECK_FG                     COLOR_YELLOW
+#define CHECK_BG                     COLOR_BLACK
 #define CHECK_HL                     FALSE
 
-#define CHECK_SELECTED_FG            COLOR_WHITE
-#define CHECK_SELECTED_BG            COLOR_BLUE
+#define CHECK_SELECTED_FG            COLOR_YELLOW
+#define CHECK_SELECTED_BG            COLOR_RED
 #define CHECK_SELECTED_HL            TRUE
 
-#define UARROW_FG                    COLOR_GREEN
-#define UARROW_BG                    COLOR_WHITE
-#define UARROW_HL                    TRUE
-
-#define DARROW_FG                    COLOR_GREEN
-#define DARROW_BG                    COLOR_WHITE
-#define DARROW_HL                    TRUE
+#define UARROW_FG                    COLOR_RED
+#define UARROW_BG                    COLOR_BLACK
+#define UARROW_HL                    FALSE
+
+#define DARROW_FG                    COLOR_RED
+#define DARROW_BG                    COLOR_BLACK
+#define DARROW_HL                    FALSE
 
 /* End of default color definitions */
 

--wzJLGUyc3ArbnUjN--
