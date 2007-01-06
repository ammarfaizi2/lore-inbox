Return-Path: <linux-kernel-owner+w=401wt.eu-S1751379AbXAFMu7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751379AbXAFMu7 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 07:50:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751380AbXAFMu7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 07:50:59 -0500
Received: from fallback.mail.ru ([194.67.57.14]:3741 "EHLO mx4.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751379AbXAFMu7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 07:50:59 -0500
X-Greylist: delayed 3898 seconds by postgrey-1.27 at vger.kernel.org; Sat, 06 Jan 2007 07:50:58 EST
From: "Cyrill V. Gorcunov" <gclion@mail.ru>
Reply-To: gclion@mail.ru
To: zippel@linux-m68k.org
Subject: qconf handling NULL pointers
Date: Sat, 6 Jan 2007 14:44:18 +0300
User-Agent: KMail/1.9.5
Cc: kernel list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701061444.18384.gclion@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Roman

I found qconf have a few malloc(), strdup() without any check for NULL returned code.
May be it should be fixed? Am I wrong?

-- 
	- Cyrill
