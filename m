Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274305AbRIZLTe>; Wed, 26 Sep 2001 07:19:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274307AbRIZLTY>; Wed, 26 Sep 2001 07:19:24 -0400
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:57611 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S274305AbRIZLTI>; Wed, 26 Sep 2001 07:19:08 -0400
Date: Wed, 26 Sep 2001 13:19:31 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: login vs. portmap revisited
Message-ID: <20010926131931.D5832@emma1.emma.line.org>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently dug through the mail archives to figure why my login requires
portmap. It seems that poll or recvfrom return semantics  have changed
from 2.2 to 2.4, and some login or PAM didn't track the change.

Does anyone have details on this? Whom do I ask for updates? PAM guys?
glibc guys? "login" maintainer?

-- 
Matthias Andree

"Those who give up essential liberties for temporary safety deserve
neither liberty nor safety." - Benjamin Franklin
