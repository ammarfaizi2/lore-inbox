Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314351AbSEXNeb>; Fri, 24 May 2002 09:34:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314381AbSEXNea>; Fri, 24 May 2002 09:34:30 -0400
Received: from c2ce9fba.adsl.oleane.fr ([194.206.159.186]:435 "EHLO
	avalon.france.sdesigns.com") by vger.kernel.org with ESMTP
	id <S314351AbSEXNe3>; Fri, 24 May 2002 09:34:29 -0400
To: linux-kernel@vger.kernel.org
Subject: tasklet scheduled after end of rmmod
From: Emmanuel Michon <emmanuel_michon@realmagic.fr>
Date: 24 May 2002 15:34:27 +0200
Message-ID: <7wptzlllek.fsf@avalon.france.sdesigns.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

as far as I understand nothing prevents a scheduled tasklet to have
Linux jump to its routine, when the routine is in a module being
rmmod'd. How should I take care of this?

Are timers safe regarding this (I mean, we can consider the timer
function won't be called as soon as del_timer() has returned)?

Sincerely yours,

-- 
Emmanuel Michon
Chef de projet
REALmagic France SAS
Mobile: 0614372733 GPGkeyID: D2997E42  
