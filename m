Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932492AbWEPRvQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932492AbWEPRvQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 13:51:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932364AbWEPRvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 13:51:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:23448 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932462AbWEPRu1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 13:50:27 -0400
From: Andreas Schwab <schwab@suse.de>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: James Morris <jmorris@namei.org>, Alexey Dobriyan <adobriyan@gmail.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH] selinux: endian fix
References: <20060516152305.GI10143@mipter.zuzino.mipt.ru>
	<Pine.LNX.4.64.0605161149540.16379@d.namei>
	<jeiro6sztd.fsf@sykes.suse.de>
	<Pine.LNX.4.61.0605161941360.26842@yvahk01.tjqt.qr>
X-Yow: An Italian is COMBING his hair in suburban DES MOINES!
Date: Tue, 16 May 2006 19:50:25 +0200
In-Reply-To: <Pine.LNX.4.61.0605161941360.26842@yvahk01.tjqt.qr> (Jan
	Engelhardt's message of "Tue, 16 May 2006 19:42:05 +0200 (MEST)")
Message-ID: <jebqtxuae6.fsf@sykes.suse.de>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt <jengelh@linux01.gwdg.de> writes:

>>>> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
>>>
>>> Hmm, I'm certain this was tested (perhaps on a BE machine, though).
>>
>>ntohs and htons are identical operations.  Either you swap or you don't,
>>but there is only one way to swap a short.
>>
> ...unless PDPs start to get attractive again. :>

No.  There are only two ways to order two bytes.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
