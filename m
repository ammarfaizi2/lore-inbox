Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265477AbTAFA32>; Sun, 5 Jan 2003 19:29:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265523AbTAFA31>; Sun, 5 Jan 2003 19:29:27 -0500
Received: from hell.ascs.muni.cz ([147.251.60.186]:8832 "EHLO
	hell.ascs.muni.cz") by vger.kernel.org with ESMTP
	id <S265477AbTAFA31>; Sun, 5 Jan 2003 19:29:27 -0500
Date: Mon, 6 Jan 2003 01:38:02 +0100
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: linux-kernel@vger.kernel.org
Subject: 2.5.54 - quota support
Message-ID: <20030106003801.GA522@mail.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
X-Muni: zakazka, vydelek, firma, komerce, vyplata
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, Mossad, Iraq, Pentagon, WTC, president, assassination, A-bomb, kua, vic joudu uz neznam
X-policie-CR: Neserte mi nebo ukradnu, vyloupim, vybouchnu, znasilnim, zabiju, podpalim, umucim, podriznu, zapichnu a vubec vsechno
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Is quota support currently broken?

Under 2.5.54 I got:
# quotaon /
using //aquota.user on /dev/hda1: No such device

/dev/hda1 is ext3 and aquota.user exists on it.

My config is:
CONFIG_QUOTA=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y

-- 
Luká¹ Hejtmánek
