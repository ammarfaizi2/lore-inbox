Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285516AbSACL2i>; Thu, 3 Jan 2002 06:28:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285517AbSACL22>; Thu, 3 Jan 2002 06:28:28 -0500
Received: from monster.nni.com ([216.107.0.51]:54027 "EHLO admin.nni.com")
	by vger.kernel.org with ESMTP id <S285516AbSACL2U>;
	Thu, 3 Jan 2002 06:28:20 -0500
From: "Andrew Rodland" <arodland@noln.com>
Subject: Re: CML2 funkiness
To: esr@thyrsus.com
Cc: linux-kernel@vger.kernel.org
X-Mailer: CommuniGate Pro Web Mailer v.3.5
Date: Thu, 03 Jan 2002 06:28:20 -0500
Message-ID: <web-54832860@admin.nni.com>
In-Reply-To: <20020103023105.A5434@thyrsus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After sleep and further thought, that makes perfect sense.

On Thu, 3 Jan 2002 02:31:05 -0500
 "Eric S. Raymond" <esr@thyrsus.com> wrote:
> I think the right thing will be to write private symbols
>  into config.out,
> but with an attached PRIVATE label that stops
>  configtrans.py from 
> translating these into defines for the autoconf.h file.
> 
> That's what I've done for the upcoming CML 2.0.0 release.
> -- 
