Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263268AbTIAVmE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 17:42:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263295AbTIAVmE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 17:42:04 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:39811
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S263268AbTIAVmC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 17:42:02 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: linux-kernel@vger.kernel.org
Subject: Make clean misses stuff in 2.6.0-test4.
Date: Mon, 1 Sep 2003 17:42:37 -0400
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309011742.37021.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I did a build as root, did a make clean (still as root), and then kicked off a 
build as my normal user account:

It died:

rm: cannot remove `.tmp_versions/cryptoloop.mod': Permission denied
rm: cannot remove `.tmp_versions/orinoco.mod': Permission denied
rm: cannot remove `.tmp_versions/hermes.mod': Permission denied
rm: cannot remove `.tmp_versions/orinoco_cs.mod': Permission denied
rm: cannot remove `.tmp_versions/orinoco_tmd.mod': Permission denied
rm: cannot remove `.tmp_versions/snd-seq-midi.mod': Permission denied
rm: cannot remove `.tmp_versions/snd-rawmidi.mod': Permission denied
rm: cannot remove `.tmp_versions/snd-mpu401-uart.mod': Permission denied
rm: cannot remove `.tmp_versions/snd-ac97-codec.mod': Permission denied
rm: cannot remove `.tmp_versions/snd-ali5451.mod': Permission denied

Rob
