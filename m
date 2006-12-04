Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937291AbWLDTBt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937291AbWLDTBt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 14:01:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937294AbWLDTBt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 14:01:49 -0500
Received: from torrent.CC.McGill.CA ([132.206.27.49]:46274 "EHLO
	torrent.cc.mcgill.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937291AbWLDTBr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 14:01:47 -0500
Subject: hda-intel broken under 2.6.19
From: David Ronis <ronis@ronispc.chem.mcgill.ca>
Reply-To: David.Ronis@mcgill.ca
To: linux-kernel@vger.kernel.org
Cc: linux-sound@vger.kernel.org
Content-Type: text/plain
Organization: Chemistry Department, McGill University
Date: Mon, 04 Dec 2006 14:01:34 -0500
Message-Id: <1165258894.5776.9.camel@ronispc.chem.mcgill.ca>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've just upgraded a i686 dual box from 2.6.18.3 to 2.6.19 on a .  (I
had been running ALSA 1.0.13.rc3 and also upgraded to the release for
for library and utility programs).  The hda-intel driver had problems
with initializing the mic (e.g., using skype for linux), but played
sound properly.  Since upgrading, that no longer works (e.g, using aplay
or mpg123).

I've reconfigured alsa, and upgraded the libs and utils to the 1.0.13
release.

Anybody else have this problem?  Any suggestions?

David



