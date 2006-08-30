Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751386AbWH3Tg7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751386AbWH3Tg7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 15:36:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751375AbWH3Tg7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 15:36:59 -0400
Received: from mail.suse.de ([195.135.220.2]:55969 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751386AbWH3Tg7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 15:36:59 -0400
From: Andi Kleen <ak@suse.de>
To: Willy Tarreau <w@1wt.eu>
Subject: Re: [PATCH][RFC] exception processing in early boot
Date: Wed, 30 Aug 2006 21:36:54 +0200
User-Agent: KMail/1.9.3
Cc: pageexec@freemail.hu, davej@redhat.com, linux-kernel@vger.kernel.org
References: <20060830063932.GB289@1wt.eu> <200608302026.05968.ak@suse.de> <20060830190125.GA21041@1wt.eu>
In-Reply-To: <20060830190125.GA21041@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608302136.54624.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Andi, if you remove the HLT here, some CPUs will spin at full speed. This
> is nasty during boot because some of them might not have enabled their
> fans yet for instance

That would be a severe bug in the platform. Basically always the fans are managed
by SMM code.

-Andi
