Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270454AbRHHL14>; Wed, 8 Aug 2001 07:27:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270455AbRHHL1r>; Wed, 8 Aug 2001 07:27:47 -0400
Received: from elin.scali.no ([195.139.250.10]:5130 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S270454AbRHHL1e>;
	Wed, 8 Aug 2001 07:27:34 -0400
Subject: Telling the difference between threads and processes
From: Terje Eggestad <terje.eggestad@scali.no>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.12 (Preview Release)
Date: 08 Aug 2001 13:27:23 +0200
Message-Id: <997270043.11431.9.camel@pc-16>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It started when I got annoyed with gtop's report on resident sizes
and that the sum of resident sizes can be twice that of physical mem.

Turns out that gtop adds the RS of threads and it should be a simple
fix to gtop. 

The trouble is that I can't see a proof way from /proc/<pids> to figure
out if the process was clone()'ed with CLONE_VM or not. Is there???

-- 
_________________________________________________________________________

Terje Eggestad                  terje.eggestad@scali.no
Scali Scalable Linux Systems    http://www.scali.com

Olaf Helsets Vei 6              tel:    +47 22 62 89 61 (OFFICE)
P.O.Box 70 Bogerud                      +47 975 31 574  (MOBILE)
N-0621 Oslo                     fax:    +47 22 62 89 51
NORWAY            
_________________________________________________________________________

