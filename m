Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267992AbTAIUbY>; Thu, 9 Jan 2003 15:31:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267993AbTAIUbY>; Thu, 9 Jan 2003 15:31:24 -0500
Received: from [195.20.32.236] ([195.20.32.236]:35018 "HELO euro.verza.com")
	by vger.kernel.org with SMTP id <S267992AbTAIUbX>;
	Thu, 9 Jan 2003 15:31:23 -0500
Date: Thu, 9 Jan 2003 21:35:01 +0100
From: Alexander Kellett <lypanov@kde.org>
To: perex@suse.cz
Cc: linux-kernel@vger.kernel.org
Subject: ALSA Kconfig comment change - Solo-1 1969
Message-ID: <20030109203501.GA29154@groucho.verza.com>
Mail-Followup-To: perex@suse.cz, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Disclaimer: My opinions do not necessarily represent those of my employer
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maybe it might be nice to update the Kconfig in sound/pci
to the following section:
   config SND_ES1938
     tristate "ESS ES1938/1946/1969 (Solo-1)"
     depends on SND && SOUND_GAMEPORT
     help
     Say 'Y' or 'M' to include support for ESS Solo-1 
     (ES1938, ES1946, ES1969) soundcard.
(sorry for lack of diff, and for whitespace changes!)

I was most confused to see Solo-1 but no support for my soundcard :)

Alex

-- 
"[...] Konqueror open source project. Weighing in at less than
            one tenth the size of another open source renderer"
Apple,  Jan 2003 (http://www.apple.com/safari/)
