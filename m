Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751668AbWEPQYT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751668AbWEPQYT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 12:24:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751669AbWEPQYS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 12:24:18 -0400
Received: from mx1.suse.de ([195.135.220.2]:10146 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751663AbWEPQYS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 12:24:18 -0400
From: Andreas Schwab <schwab@suse.de>
To: James Morris <jmorris@namei.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH] selinux: endian fix
References: <20060516152305.GI10143@mipter.zuzino.mipt.ru>
	<Pine.LNX.4.64.0605161149540.16379@d.namei>
X-Yow: It's so OBVIOUS!!
Date: Tue, 16 May 2006 18:24:14 +0200
In-Reply-To: <Pine.LNX.4.64.0605161149540.16379@d.namei> (James Morris's
	message of "Tue, 16 May 2006 11:54:04 -0400 (EDT)")
Message-ID: <jeiro6sztd.fsf@sykes.suse.de>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Morris <jmorris@namei.org> writes:

> On Tue, 16 May 2006, Alexey Dobriyan wrote:
>
>> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
>
> Hmm, I'm certain this was tested (perhaps on a BE machine, though).

ntohs and htons are identical operations.  Either you swap or you don't,
but there is only one way to swap a short.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
