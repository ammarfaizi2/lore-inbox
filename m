Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932246AbWEPRmW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932246AbWEPRmW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 13:42:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932225AbWEPRmW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 13:42:22 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:17026 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932246AbWEPRmU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 13:42:20 -0400
Date: Tue, 16 May 2006 19:42:05 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Andreas Schwab <schwab@suse.de>
cc: James Morris <jmorris@namei.org>, Alexey Dobriyan <adobriyan@gmail.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH] selinux: endian fix
In-Reply-To: <jeiro6sztd.fsf@sykes.suse.de>
Message-ID: <Pine.LNX.4.61.0605161941360.26842@yvahk01.tjqt.qr>
References: <20060516152305.GI10143@mipter.zuzino.mipt.ru>
 <Pine.LNX.4.64.0605161149540.16379@d.namei> <jeiro6sztd.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
>>
>> Hmm, I'm certain this was tested (perhaps on a BE machine, though).
>
>ntohs and htons are identical operations.  Either you swap or you don't,
>but there is only one way to swap a short.
>
...unless PDPs start to get attractive again. :>


Jan Engelhardt
-- 
