Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261910AbTICLgO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 07:36:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261917AbTICLgO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 07:36:14 -0400
Received: from chello080109223066.lancity.graz.surfer.at ([80.109.223.66]:55427
	"EHLO lexx.delysid.org") by vger.kernel.org with ESMTP
	id S261910AbTICLgK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 07:36:10 -0400
To: linux-kernel@vger.kernel.org
Subject: No SFM when using SiSFB and FB-console
From: Mario Lang <mlang@delysid.org>
Date: Wed, 03 Sep 2003 13:36:14 +0200
Message-ID: <873cfehzo1.fsf@lexx.delysid.org>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

When booting 2.6.0-test4 with sisfb (630) and FB-console built-in,
it appears that I have no sfm defined by default.

consolechars -U generates an empty file.

This makes my braille display driver daemon very unhappy,
and all the characters on the screen are shown as question marks on my
braille display.

I found out that if I export the sfm of my 2.4.20 machine
and consolechars -u that file under 2.6.0-test4, BRLTTY
seems to be happy again.

Can anyone explain 
 1.: Is it a bug that upon boot with console fb, there is no default sfm?
 2.: If not, how can I convince the kernel to provide a default sfm, without
     having to load one from user-space?

P.S.: I am not subscribed, so please CC me.

-- 
CYa,
  Mario
