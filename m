Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262815AbVCDB0f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262815AbVCDB0f (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 20:26:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262687AbVCDB0U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 20:26:20 -0500
Received: from hs-grafik.net ([80.237.205.72]:12172 "EHLO
	ds80-237-205-72.dedicated.hosteurope.de") by vger.kernel.org
	with ESMTP id S262689AbVCDBYg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 20:24:36 -0500
From: Alexander Gran <alex@zodiac.dnsalias.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.11-rc5-mm1: reiser4 eating cpu time
Date: Fri, 4 Mar 2005 02:24:36 +0100
User-Agent: KMail/1.7.2
X-Need-Girlfriend: always
X-Ignorant-User: yes
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503040224.36516@zodiac.zodiac.dnsalias.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a reiser4 partition on a local IDE disk. I opened a 130MB textfile with 
kwrite, and killed it while ot opened the file (took to long...) diskio was 
finished at this point.
a [ent:hda6.] Process was eating 100% CPU time for several (54) seconds.
Is this a normal, expected behaviour?
After trying again, pdflush was eating much cpu time, about the same (50+ 
secs) Note that this happend after reiser4 panic (on an external disk as 
reported several minutes ago).

regards
Alex
-- 
Encrypted Mails welcome.
PGP-Key at http://zodiac.dnsalias.org/misc/pgpkey.asc | Key-ID: 0x6D7DD291
