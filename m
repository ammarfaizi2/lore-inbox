Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315701AbSENNRC>; Tue, 14 May 2002 09:17:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315709AbSENNRB>; Tue, 14 May 2002 09:17:01 -0400
Received: from imladris.infradead.org ([194.205.184.45]:57872 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S315701AbSENNRB>; Tue, 14 May 2002 09:17:01 -0400
Date: Tue, 14 May 2002 14:16:46 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Alan Cox <alan@redhat.com>, andre@linux-ide.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19pre8-ac3
Message-ID: <20020514141646.A27239@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Alan Cox <alan@redhat.com>, andre@linux-ide.org,
	linux-kernel@vger.kernel.org
In-Reply-To: <200205141244.g4ECi6P29886@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> o	Major IDE updates				(Andre Hedrick)

What was the reason to add {__,}save_and_sti and {__,}save_and_cli
if the former is only used under a never defined ifdef or in another
<asm/system.h> macro and the latter isn't used at all?

	Christoph

P.S.  Sorry Andre, I wanted to ask that earlier but forgot it until it
got merged..


