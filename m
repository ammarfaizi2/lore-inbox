Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262111AbTELMmo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 08:42:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262112AbTELMmo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 08:42:44 -0400
Received: from Mail1.KONTENT.De ([81.88.34.36]:18611 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S262111AbTELMmo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 08:42:44 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Oleg Drokin <green@namesys.com>, lkhelp@rekl.yi.org
Subject: Re: 2.5.69, IDE TCQ can't be enabled
Date: Mon, 12 May 2003 14:55:58 +0200
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.53.0305092018530.16627@rekl.yi.org> <20030512124654.GA2699@namesys.com>
In-Reply-To: <20030512124654.GA2699@namesys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305121455.58022.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Just a note that we have found TCQ unusable on our IBM drives and we had
> some reports about TCQ unusable on some WD drives.
>
> Unusable means severe FS corruptions starting from mount.
> So if your FSs will suddenly start to break, start looking for cause with
> disabling TCQ, please.

I can confirm that. This drive Model=IBM-DTLA-307045, FwRev=TX6OA60A, 
SerialNo=YMCYMT3Y229 has eaten my filesystem with TCQ on 2.5.69

	Regards
		Oliver

